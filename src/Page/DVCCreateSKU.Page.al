page 62700 "DVC Create SKU"
{
    ApplicationArea = All;
    Caption = 'Create SKU''s';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Tasks;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Locations)
            {
                ShowCaption = false;
                part(location; "DVC Locations")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create SKU's")
            {
                ApplicationArea = Planning;
                Caption = 'Create SKU''s';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MassUpdateMgt: Codeunit "DVC MassUpdate Mgt.";
                    location: Record Location;
                    StockkeepingUnit: Record "Stockkeeping Unit";
                begin
                    CurrPage.location.Page.SetSelectionFilter(location);
                    MassUpdateMgt.CreateSKUs(Rec, location);
                    Commit();
                    SelectLatestVersion();
                    MassUpdateMgt.SelectSKUs(Rec, location, StockkeepingUnit);
                    MassUpdateMgt.OpenMassUpdate(StockkeepingUnit);
                end;
            }
        }
    }
}
