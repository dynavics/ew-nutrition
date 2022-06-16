page 62701 "DVC Locations"
{
    Caption = 'Locations';
    PageType = ListPart;
    SourceTable = Location;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a location code for the warehouse or distribution center where your items are handled and stored before being sold.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name or address of the location.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies the value of the Name 2 field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
