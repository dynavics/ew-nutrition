pageextension 62700 "DVC Item List" extends "Item List"
{
    actions
    {
        addafter("Item Reclassification Journal")
        {
            action("Create SKU''s")
            {
                ApplicationArea = Planning;
                CaptionML = ENU = 'Create SKU''s', ENG = 'Create SKU''s', ESP = 'Crear SKUs';
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
