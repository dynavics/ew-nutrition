pageextension 62700 "DVC Item List" extends "Item List"
{
    actions
    {
        addafter("Item Reclassification Journal")
        {
            action("Create SKU''s")
            {
                ApplicationArea = Planning;
                Caption = 'Create SKU''s';
                Image = CreateSKU;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MassUpdateMgt: Codeunit "DVC MassUpdate Mgt.";
                    Item: Record Item;
                begin
                    CurrPage.SetSelectionFilter(Item);
                    MassUpdateMgt.OpenCreateSKUs(Item);
                end;
            }
        }
    }
}
