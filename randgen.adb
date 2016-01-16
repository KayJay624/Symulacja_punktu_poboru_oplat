with Ada.Numerics.Float_Random, Ada.Float_Text_IO;
use Ada.Numerics.Float_Random, Ada.Float_Text_IO;

package body RandGen is
	Gen: Generator;
   function GenRandFloat(dolna: in Float; gorna : in Float) return Float is
       
   begin
      
      
      return (Random(Gen)*(gorna - dolna) + dolna);
   end GenRandFloat;
begin
	Reset(Gen);	

end RandGen;