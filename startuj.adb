with kontroler, JEWL.Simple_Windows, Ada.Task_Identification, Ada.Text_IO, JEWL.IO;
use  kontroler, JEWL.Simple_Windows, Ada.Task_Identification, Ada.Text_IO, JEWL.IO;

procedure startuj is

	My_Frame : Frame_Type := Frame (240, 400, "Symulacja", 'Q');
	ileSamochodowLbl     : Label_Type   := Label (My_Frame, (10,10), 150, 20, "liczba samochodow: ", Left);
  	ileSamochodowEBox    : Editbox_Type := Editbox (My_Frame, (150,10), 50, 20, "100");
    
    ileBramekLbl         : Label_Type   := Label (My_Frame, (10,40), 150, 20, "liczba bramek: ", Left);
    ileBramekEBox        : Editbox_Type := Editbox (My_Frame, (150,40), 50, 20, "5");
    
    czasGeneracjiLbl     : Label_Type   := Label (My_Frame, (10,70), 150, 20, "czestotliwosc generacji: ", Left);
    czasGeneracjiEbox    : Editbox_Type := Editbox (My_Frame, (150,70), 50, 20, "0.5");
  	
  	czasObslugiDLbl     : Label_Type   := Label (My_Frame, (10,100), 150, 20, "czas obslugi (min): ", Left);
    czasObslugiDEbox    : Editbox_Type := Editbox (My_Frame, (150,100), 50, 20, "1.5");

    czasObslugiGLbl     : Label_Type   := Label (My_Frame, (10,120), 150, 20, "czas obslugi (max): ", Left);
    czasObslugiGEbox    : Editbox_Type := Editbox (My_Frame, (150,120), 50, 20, "3.5");

    czasDojazduLbl     : Label_Type   := Label (My_Frame, (10,150), 150, 20, "czas dojazdu: ", Left);
    czasDojazduEbox    : Editbox_Type := Editbox (My_Frame, (150,150), 50, 20, "1.0");

     oplataLbl    : Label_Type   := Label (My_Frame, (10,180), 150, 20, "Oplaty: ", Left);

    oplataALbl     : Label_Type   := Label (My_Frame, (10,200), 150, 20, "kategoria A: ", Left);
    oplataAEbox    : Editbox_Type := Editbox (My_Frame, (150,200), 50, 20, "8");

    oplataBLbl     : Label_Type   := Label (My_Frame, (10,220), 150, 20, "kategoria B: ", Left);
    oplataBEbox    : Editbox_Type := Editbox (My_Frame, (150,220), 50, 20, "15");
    
    oplataCLbl     : Label_Type   := Label (My_Frame, (10,240), 150, 20, "kategoria C: ", Left);
    oplataCEbox    : Editbox_Type := Editbox (My_Frame, (150,240), 50, 20, "16");
    
    oplataDLbl     : Label_Type   := Label (My_Frame, (10,260), 150, 20, "kategoria D: ", Left);
    oplataDEbox    : Editbox_Type := Editbox (My_Frame, (150,260), 50, 20, "85");


  	startBtn    		 : Button_Type  := Button (My_Frame, (60,300), 100, 40, "Startuj", 'X');
 
   	ileS : Integer := 100;
    ileB : Integer := 5;
    czas : Float := 0.5;
    czasD : Float := 1.5;
    czasG : Float := 3.5;
    czasDoj : Float := 1.0;
    A: Integer := 8;
    B: Integer := 15;
    C: Integer := 16;
    D: Integer := 85;

	begin
        
	  loop
        <<Poczatek>>
		case Next_Command is
		  when 'Q' =>
		    exit;
		  
		  when 'X' =>
		    begin
            ileS := Integer'Value(Get_Text(ileSamochodowEBox));
		    ileB := Integer'Value(Get_Text(ileBramekEBox));
		    czas := Float'Value(Get_Text(czasGeneracjiEbox));
		    czasD := Float'Value(Get_Text(czasObslugiDEbox));
		    czasG := Float'Value(Get_Text(czasObslugiGEbox));
		    czasDoj := Float'Value(Get_Text(czasDojazduEbox));
		    A := Integer'Value(Get_Text(oplataAEbox));
		    B := Integer'Value(Get_Text(oplataBEbox));
		    C := Integer'Value(Get_Text(oplataCEbox));
		    D := Integer'Value(Get_Text(oplataDEbox));
		     
            symuluj(ileB, ileS, czas, czasD, czasG, czasDoj,A,B,C,D);
		    
             exception --gdy podana zla wartosc (zawierajaca inne znaki niz cyfry).
               when Constraint_error => Message ("Podaj poprawna wartosc!"); goto Poczatek;
               
               when others => Message ("Nieznany Problem!");  goto Poczatek;
            end;
		  when others =>
		    null;
		
		end case;


	  end loop;

      
            --end;

end startuj;



