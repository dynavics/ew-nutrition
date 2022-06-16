pageextension 62701 "DVC Stockkeeping Unit List" extends "Stockkeeping Unit List"
{
    actions
    {
        addafter("C&alculate Counting Period")
        {
            action("Mass Update")
            {
                ApplicationArea = Planning;
                Caption = 'Mass Update';
                Image = CreateSKU;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MassUpdateMgt: Codeunit "DVC MassUpdate Mgt.";
                    StockkeepingUnit: Record "Stockkeeping Unit";
                begin
                    CurrPage.SetSelectionFilter(StockkeepingUnit);
                    MassUpdateMgt.OpenMassUpdate(StockkeepingUnit);
                end;
            }
        }
    }
}
