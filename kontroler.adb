with Ada.Text_IO, Liczniki, Kolejki, RandGen, JEWL.Simple_Windows,Ada.Task_Identification, Ada.Float_Text_Io,Ada.Calendar;
use  Ada.Text_IO, Liczniki, Kolejki, RandGen, JEWL.Simple_Windows,Ada.Task_Identification, Ada.Float_Text_Io,Ada.Calendar;

package body kontroler is
  procedure symuluj(ileBudek: in Integer; ileSamochodow : in Integer; czasPrzyjazdu: in Float; czasObslugiD : in Float; czasObslugiG : in Float; czasDojazdu : in Float; oplataA: in Integer; oplataB: in Integer;oplataC: in Integer;oplataD: in Integer) is
    
    licznikP : licznikPieniedzy;
    --pragma atomic(licznikP);

    licznikS : licznikSamochodow; 
    --PRAGMA atomic(licznikS);
             
    Kolejki : array (1 .. ileBudek) of Kolejka_Access;  
    F : Frame_Type  := Frame (104*ileBudek+150, 720, "Punkt poboru oplat - symulacja", 'Q');   
    tabCanvas : array(1.. ileBudek) of Canvas_Type; 
    panelX : Integer := 100*ileBudek;
    panel : Canvas_Type := Canvas (F, (panelX,0), 150, 300, 'X', 'X');
    Fill_Colour : Colour_Dialog_Type := Colour_Dialog;
    czasSym : Time := Clock;

    task type GeneratorSamochodow; 
    task body GeneratorSamochodow is
    Index : Integer := 1;
    C : Buffer_Count;
    Min : Buffer_Count;
    X : Integer := 1;
    begin
      for I in Integer range 1..ileSamochodow loop
        --Put_Line("$ wstawiam: samochod o nr  :  '" &Integer'Image(I) &"'");
        
        -- szukanie kolejki o najmniejszej liczbie samochodow
        Min := Kolejki(1).GetCount;   
        Index := 1;            
        for J in Integer range Kolejki'First+1 .. Kolejki'Last loop
            C := Kolejki(J).GetCount;
            if C < Min then
                Min := C;
                Index := J;
            end if;           
        end loop;

        -- wstawianie nowo wygenerowanego samochodu do odpowiedniej kolejki
        Kolejki(Index).Put(I);
        
        -- rysowanie nowo wygenerowanego samochodu
        Set_Colour (Fill_Colour, Blue);
        Set_Fill (tabCanvas(Index), Get_Colour(Fill_Colour));
        Draw_Rectangle(tabCanvas(Index),(20,100*(Kolejki(Index).GetCount+1)),(80,100*(Kolejki(Index).GetCount+1)+90));

        -- odswiezenie liczby oczekujacych
        Set_Colour (Fill_Colour, White);
        Set_Fill (tabCanvas(Index), Get_Colour(Fill_Colour));
        Set_Pen (tabCanvas(Index), White, 1);
        Draw_Rectangle(tabCanvas(Index),(15,45),(85,60));
        Draw_Text(tabCanvas(Index),(18,45),"czeka: " & Integer'Image(Kolejki(Index).GetCount));

        --Put_Line("$ wstawilem samochod nr: " & Integer'Image(I)  & " do kolejki nr: " & Integer'Image(Index));
        
        -- czestotliwsc generacji nowego samochodu
        delay Duration(czasPrzyjazdu);
      end loop;
    end GeneratorSamochodow;

    type Generator_Access is access GeneratorSamochodow;

    task type Budka(Id: Integer := 1) is
    end Budka;

    task body Budka is
      S : Samochod;
      licznikObsluzonych : Integer := 0;
      czasObslugi : Float;
      
    begin
      loop
        Put_Line("# W kolejce nr " &Integer'Image(Id) & " jest:" &Integer'Image(Kolejki(Id).GetCount));

        -- pobieram somochod z kolejki
        Kolejki(Id).Get(S);
        licznikObsluzonych := licznikObsluzonych + 1;

        if S mod 20 = 0 then
          licznikP.Put(oplataD);
        elsif S mod 5 = 0 then
          licznikP.Put(oplataC);
        elsif S mod 4 = 0 then
          licznikP.Put(oplataB);
        else 
          licznikP.Put(oplataA);
        end if;
        
        LicznikS.Put;

        Put_Line("# Budka o id: " & Integer'Image(Id) & " obsluzyla samochod o nr: '" &Integer'Image(S) & "'");
        Put_Line("# Budka o id: " & Integer'Image(Id) & " obsluzyla " &Integer'Image(licznikObsluzonych) & " samochodow");
        Put_Line("# w kasie jest : '" & Integer'Image(licznikP.Get) & "' PLN");
       
        czasObslugi := GenRandFloat(czasObslugiD, czasObslugiG);
        Put_Line("czas obslugi : " & Float'Image(czasObslugi));
        
        -- wyswietlanie parametrow  budki
        Set_Colour (Fill_Colour, White);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Set_Pen (tabCanvas(id), Black, 1);
        Draw_Text(tabCanvas(id),(15,10),"Bramka :" & Integer'Image(Id));                    
        
        Set_Pen (tabCanvas(id), White, 1);
        Draw_Rectangle(tabCanvas(id),(15,45),(85,60));
        Draw_Text(tabCanvas(id),(18,45),"czeka: " & Integer'Image(Kolejki(id).GetCount));
        Draw_Rectangle(tabCanvas(id),(10,60),(90,75));
        Draw_Text(tabCanvas(id),(14,60),"counter: " & Integer'Image(licznikObsluzonych));
        
        Draw_Text(panel,(60,10),"Panel"); 

        -- rysowanie obslugiwanego samochodu jako czerwonego prostokata
        Set_Colour (Fill_Colour, Red);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Draw_Rectangle(tabCanvas(id),(20,100),(80,190));

        Set_Colour (Fill_Colour, Black);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Draw_Text(tabCanvas(id),(40,130),Integer'Image(S));  
        

        -- bramka obsluguje samochod
        delay Duration(czasObslugi);


        -- wyswietlanie licznika pieniedzy i samochodow
        Set_Colour (Fill_Colour, Gray);
        Set_Fill (panel, Get_Colour(Fill_Colour));
        Draw_Rectangle(panel,(0,0),(150,300)); 
        
        Set_Colour (Fill_Colour, Black);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Draw_Text(panel,(60,10),"Panel"); 
        Draw_Text(panel,(10,70),"Obsluzone");
        Draw_Text(panel,(10,85),"  pojazdy: " & Integer'Image(LicznikS.Get));      
        Draw_Text(panel,(10,40),"Zysk: " &  Integer'Image(licznikP.Get) & ".00 PLN");
        Draw_Text(panel,(10,110),"Czas symulacji: ");
        Draw_Text(panel,(10,125),Duration'Image(Clock - czasSym) & " s");                 

        -- bramka obsluzyla samochod, obsluzony samochod zamalowany bialym prostokatem
        Set_Colour (Fill_Colour, White);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Set_Pen (tabCanvas(id), White, 1);
        Draw_Rectangle(tabCanvas(id),(20,100),(80,190)); 
          
        -- chwila na przyjazd do bramki nowego samochodu
        delay Duration(czasDojazdu);             
        
        -- kolejny samochod podjechal pod bramke, wiec ostatni znika
        Set_Colour (Fill_Colour, White);
        Set_Fill (tabCanvas(id), Get_Colour(Fill_Colour));
        Draw_Rectangle(tabCanvas(id),(20,100*(Kolejki(Id).GetCount+1)),(80,100*(Kolejki(Id).GetCount+1)+90));

        --exit when Kolejki(Id).GetCount = 0;
      end loop;
      --Put_Line("#Pusta kolejka! Koniec budki : " & Integer'Image(Id));
    end Budka;

  type Budka_Access is access Budka;
  ------------------------------------------------------------------------------------------------------------
  gen : Generator_Access;
  budki : array (1 .. ileBudek) of Budka_Access;
  X : Integer :=0;
  Y : Integer :=0;

begin
  -- tworzenie pasow do rysowania
  for I in tabCanvas'range loop
    tabCanvas(I) := Canvas (F, (X,Y), 100, 700, 'X', 'X');
    X := X+100;
    Set_Pen (tabCanvas(I), Black, 1);
    Draw_Rectangle(tabCanvas(I),(5,5),(95,90)); 
    Draw_Text(tabCanvas(I),(15,10),"Bramka :" & Integer'Image(I));
    Draw_Text(tabCanvas(I),(15,45),"czeka: " & Integer'Image(0));          
    Draw_Text(tabCanvas(I),(15,60),"counter: " & Integer'Image(0));   
  end loop;

  -- tworzenie kolejek samochodow
  for I in kolejki'range loop
    kolejki(I) := new Kolejka;
  end loop;

  -- tworzenie generatora samochodow
  gen := new GeneratorSamochodow;

  -- tworzenie bramek
  for I in budki'range loop
    budki(I) := new Budka(I);
  end loop;

  -- obsluga klikniecia zamkniecia programu
  loop
        case Next_Command is
          when 'Q' =>
            Abort_Task (Current_Task);
            exit;
          when others =>
            null;
        end case;
      end loop;
end symuluj; 

end kontroler;

