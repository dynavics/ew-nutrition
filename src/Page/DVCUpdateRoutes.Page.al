page 62703 "DVC Update Routes"
{
    Caption = 'DVC Update Routes';
    PageType = List;
    SourceTable = Location;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            Group("New Data")
            {
                Caption = 'General';
                field(LocationPosition; LocationPosition)
                {
                    CaptionML = ENU = 'Location Position', ENG = 'Location Position', ESP = 'Posición del almacén';
                    ApplicationArea = Location;
                }
                field("In-Transit Code"; InTransitCode)
                {
                    CaptionML = ENU = 'In-Transit Code', ENG = 'In-Transit Code', ESP = 'Cód. En-tránsito';
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the in-transit code for the transfer order, such as a shipping agent.';
                    TableRelation = Location WHERE("Use As In-Transit" = CONST(true));
                }
                field("Shipping Agent Code"; ShippingAgentCode)
                {
                    CaptionML = ENU = 'Shipping Agent Code', ENG = 'Shipping Agent Code', ESP = 'Cód. Transportista';
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code for the shipping agent who is transporting the items.';
                    TableRelation = "Shipping Agent".Code;
                    trigger OnValidate()
                    begin
                        ShippingAgentService := '';
                    end;
                }
                field("Shipping Agent Service Code"; ShippingAgentService)
                {
                    CaptionML = ENU = 'Shipping Agent Service Code', ENG = 'Shipping Agent Service Code', ESP = 'Cód. Servicio Transportista';
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code for the service, such as a one-day delivery, that is offered by the shipping agent.';
                    trigger OnDrillDown()
                    var
                        ShippingAgentServicesPage: Page "Shipping Agent Services";
                        ShippingAgentServicesTable: Record "Shipping Agent Services";
                        Text001: TextConst ENU = 'Please, select Shipping Agent Code first.', ENG = 'Please, select Shipping Agent Code first.', ESP = 'Por favor, seleccione transportista primero.';
                    begin
                        if ShippingAgentCode = '' then
                            Error(Text001);
                        ShippingAgentServicesTable.SetRange("Shipping Agent Code", ShippingAgentCode);

                        ShippingAgentServicesPage.SetTableView(ShippingAgentServicesTable);
                        ShippingAgentServicesPage.LookupMode(true);
                        if ShippingAgentServicesPage.RunModal() = Action::LookupOK then begin
                            ShippingAgentServicesPage.GetRecord(ShippingAgentServicesTable);
                            ShippingAgentService := ShippingAgentServicesTable.Code;
                        end;
                    end;


                }
            }
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

    actions
    {
        area(Processing)
        {
            action("Process Update")
            {
                ApplicationArea = Location;
                CaptionML = ENU = 'Process Update', ENG = 'Process Update', ESP = 'Procesar Actualización';
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
                    MassUpdateMgt.UpdateRoutes(LocationPosition, Rec, InTransitCode, ShippingAgentCode, ShippingAgentService);
                end;
            }
        }
    }

    var
        InTransitCode: Code[20];
        ShippingAgentCode: Code[20];
        ShippingAgentService: Code[20];
        LocationPosition: Enum "DVC Update Route Selection";
}
