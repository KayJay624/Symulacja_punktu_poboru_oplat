package body Liczniki is
	
	protected body licznikPieniedzy is
        function Get return Integer is
        begin
            return Suma;
        end Get;

        procedure Put (I : in Integer) is
        begin
            Suma := Suma + I;
        end Put;
      
      end licznikPieniedzy;

      protected body licznikSamochodow is
        function Get return Integer is
        begin
            return Suma;
        end Get;

        procedure Put is
        begin
            Suma := Suma + 1;
        end Put;
      
      end licznikSamochodow;

end Liczniki;