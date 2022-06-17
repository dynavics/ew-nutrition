tableextension 62700 "DVC Location" extends Location
{
    fields
    {
        field(62700; "Transfer Routes as Origin"; Integer)
        {
            CaptionML = ENU = 'Transfer Routes as Origin', ENG = 'Transfer Routes as Origin', ESP = 'Rutas de Transferencia como Origen';
            CalcFormula = count("Transfer Route" where("Transfer-from Code" = field(Code)));
            FieldClass = FlowField;
        }
        field(62701; "Transfer Routes as Destination"; Integer)
        {
            CaptionML = ENU = 'Transfer Routes as Destination', ENG = 'Transfer Routes as Destination', ESP = 'Rutas de Transferencia como Destino';
            CalcFormula = count("Transfer Route" where("Transfer-to Code" = field(Code)));
            FieldClass = FlowField;
        }
    }
}
