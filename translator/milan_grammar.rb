begin             1     0
end               2     0
if                3     0
then              4     0
else              5     0
while             6     0
do                7     0
for               8     0
to                9     0
read              10    0
write             11    0
var               12    0
and               13    0
or                13    1
integer           15    0
string            16    0
;                 20    0
=                 21    0
<>                49    0
<                 50    0
>                 51    0
<=                52    0
>=                53    0
+                 22    0
-                 54    0
*                 23    0
/                 25    0
:=                24    0
(                 25    0
)                 26    0
:                 27    0
.                 28    0
,                 29    0
getcolorrgb       42    0
drawpoint         43    0
drawline          44    0
drawcircle        45    0
getpixelcolor     46    0
clrscr            47    0
color             48    0
@id               30    0
@nconst           40    0
@sconst           41    0

program           100   0
var_define        101   0
var_list          102   0
var_block         103   0
names_list        104   0
type              105   0
program_body      106   0
operators_list    107   0
operator          108   0
condition         109   0
comparation       110   0
logic_operator    111   0
expression        112   0
num_expression    113   0
str_expression    114   0
term              115   0
multiplier        116   0
str_term          117   0
color_expression  118   0
ending            119   0

<program>               ::=   <var_define> <program_body>               0   0
<var_define>            ::=   "var" <var_list>                          0   2
<var_list>              ::=   <var_block> ";" <var_list>                0   0
<var_list>              ::=   <var_block> ";"                           0   0
<var_block>             ::=   <names_list> ":" <type>                   0   0
<names_list>            ::=   "@id"                                     1   0
<names_list>            ::=   "@id" "," <names_list>                    1   0
<type>                  ::=   "integer"                                 0   0
<type>                  ::=   "string"                                  0   0
<type>                  ::=   "color"                                   0   0
<program_body>          ::=   "begin" <operators_list> "end" "."        0   0
<operators_list>        ::=   <operator>                                0   0
<operators_list>        ::=   <operator> ";" <operators_list>           0   0
<operator>              ::=   "@id" ":=" <expression>                   0   0
<operator>              ::=   "if" <condition> "then" <operator>        0   0
<operator>              ::=   "if" <condition> "then" <operator> "else" <operator>                                                                      0   0
<operator>              ::=   "while" <condition> "do" <operator>                                                                                       0   0
<operator>              ::=   "for" "@id" ":=" <expression> "to" <expression> "do" <operator>                                                           0   0
<operator>              ::=   "write" "(" <num_expression> ")"                                                                                          0   0
<operator>              ::=   "write" "(" <str_expression> ")"                                                                                          0   0
<operator>              ::=   "read" "(" "@id" ")"                                                                                                      0   0
<operator>              ::=   "drawpoint" "(" <expression> "," <expression> "," <expression> ")"                                                        0   0
<operator>              ::=   "drawline" "(" <expression> "," <expression> "," <expression> "," <expression> "," <expression> ")"                       0   0
<operator>              ::=   "drawcircle" "(" <expression> "," <expression> "," <expression> "," <expression> ")"                                      0   0
<operator>              ::=   "getpixelcolor" "(" <expression> "," <expression> ")"                                                                     0   0
<operator>              ::=   "clrscr" "(" <expression> ")"                                                                                             0   0
<operator>              ::=   "begin" <operators_list> "end"            0   0
<condition>             ::=   <comparation>                             0   0
<condition>             ::=   <condition> <logic_operator> <condition>  0   0
<comparation>           ::=   <num_expression> "=" <num_expression>     0   0
<comparation>           ::=   <str_expression> "=" <str_expression>     0   0
<comparation>           ::=   <num_expression> "<" <num_expression>     0   0
<comparation>           ::=   <str_expression> "<" <str_expression>     0   0
<comparation>           ::=   <num_expression> "<=" <num_expression>    0   0
<comparation>           ::=   <str_expression> "<=" <str_expression>    0   0
<comparation>           ::=   <num_expression> ">" <num_expression>     0   0
<comparation>           ::=   <str_expression> ">" <str_expression>     0   0
<comparation>           ::=   <num_expression> ">=" <num_expression>    0   0
<comparation>           ::=   <str_expression> ">=" <str_expression>    0   0
<comparation>           ::=   <num_expression> "<>" <num_expression>    0   0
<comparation>           ::=   <str_expression> "<>" <str_expression>    0   0
<logic_operator>        ::=   "and"                             0   0
<logic_operator>        ::=   "or"                              0   0
<expression>            ::=   <num_expression>                  0   0
<expression>            ::=   <str_expression>                  0   0
<expression>            ::=   <color_expression>                0   0
<num_expression>        ::=   <term>                            0   0
<num_expression>        ::=   <term> "+" <num_expression>       0   0
<num_expression>        ::=   <term> "-" <num_expression>       0   0
<term>                  ::=   <multiplier>                      0   0
<term>                  ::=   <multiplier> "*" <term>           0   0
<term>                  ::=   <multiplier> "/" <term>           0   0
<multiplier>            ::=   "@id"                             2   0
<multiplier>            ::=   "(" <num_expression> ")"          0   0
<multiplier>            ::=   "@nconst"                         0   0
<str_expression>        ::=   <str_term>                        0   0
<str_expression>        ::=   <str_term> "+" <str_expression>   0   0
<str_term>              ::=   "@id"                             2   0
<str_term>              ::=   "@sconst"                         0   0
<color_expression>      ::=   "@id"                             2   0
<color_expression>      ::=   "getcolorrgb" "(" <expression> "," <expression> "," <expression> ")"  0   0
