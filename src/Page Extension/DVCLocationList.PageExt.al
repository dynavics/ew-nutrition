pageextension 62702 "DVC Location List" extends "Location List"
{
    actions
    {
        addafter("&Bins")
        {
            action("Update Routes")
            {
                ApplicationArea = Location;
                Caption = 'Update Routes';
                Image = CopyRouteHeader;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MassUpdateMgt: Codeunit "DVC MassUpdate Mgt.";
                    Location: Record Location;
                begin
                    CurrPage.SetSelectionFilter(Location);
                    MassUpdateMgt.OpenUpdateRoutes(Location);
                end;
            }
        }
    }
}
