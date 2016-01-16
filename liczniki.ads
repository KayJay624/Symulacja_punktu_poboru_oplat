package Liczniki is

	protected type licznikPieniedzy is
        function Get return Integer;
        procedure Put(I: in Integer);
      
      private
        Suma : Integer := 0;
    
    end licznikPieniedzy;

    protected type licznikSamochodow is
        function Get return Integer;
        procedure Put;
      
      private
        Suma : Integer := 0;
    
    end licznikSamochodow;

end Liczniki;