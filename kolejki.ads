package Kolejki is
	
	subtype Samochod is Integer range 1..1000; 
    Maximum_Buffer_Size : constant Integer := 5;
    
    subtype Buffer_Index is Positive range 1..Maximum_Buffer_Size;
    subtype Buffer_Count is Natural  range 0..Maximum_Buffer_Size;
    type    Buffer_Array is array (Buffer_Index) of Samochod;



	protected type Kolejka is
      entry Get(S: out Samochod);
      entry Put(S: in Samochod);    
      function GetCount return Integer;
      
      private
          Pierwszy_zajety : Buffer_Index := 1;
          Pierwszy_wolny : Buffer_Index := 1;
          Count     : Buffer_Count := 0;
          Tablica      : Buffer_Array;         
    
    end Kolejka;

    type Kolejka_Access is access Kolejka;
    type tabKolejek is array(Integer range<>) of Kolejka_Access;

end Kolejki;