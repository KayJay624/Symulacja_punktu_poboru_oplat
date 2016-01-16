package body Kolejki is

	protected body Kolejka is
        entry Get (S : out Samochod) when Count > 0 is
        begin
            S := Tablica(Pierwszy_zajety);
            Pierwszy_zajety := (Pierwszy_zajety mod Maximum_Buffer_Size) + 1;
            Count := Count - 1;
        end Get;

        entry Put (S : in Samochod) when Count < Maximum_Buffer_Size is
        begin
            Tablica(Pierwszy_wolny) := S;
            Pierwszy_wolny := (Pierwszy_wolny mod Maximum_Buffer_Size) + 1;
            Count := Count + 1;
        end Put;

        function GetCount return Integer is
        begin
            return Integer(Count);
        end GetCount;
    end Kolejka;

end Kolejki;