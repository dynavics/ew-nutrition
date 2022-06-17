page 62702 "DVC Mass Update"
{
    ApplicationArea = All;
    Caption = 'Mass Update';
    PageType = List;
    SourceTable = "Stockkeeping Unit";
    UsageCategory = Tasks;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(content)
        {

            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System HEADER"; SKUReplenishmentSystemField)
                {
                    ApplicationArea = Planning;
                    CaptionML = ENU = 'Replenishment System', ENG = 'Replenishment System', ESP = 'Sistema Reposición';
                    Importance = Promoted;
                    ToolTip = 'Specifies the type of supply order that is created by the planning system when the SKU needs to be replenished.';
                }
                field("Lead Time Calculation HEADER"; LeadtimecalculationField)
                {
                    CaptionML = ENU = 'Lead Time Calculation', ENG = 'Lead Time Calculation', ESP = 'Plazo Entrega (Días)';
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                /*  group(Purchase)
                 {
                     Caption = 'Purchase';
                     field("Vendor No. HEADER"; Rec."Vendor No.")
                     {
                         ApplicationArea = Planning;
                         ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                     }
                     field("Vendor Item No. HEADER"; Rec."Vendor Item No.")
                     {
                         ApplicationArea = Planning;
                         ToolTip = 'Specifies the number that the vendor uses for this item.';
                     }
                 } */
                group(Transfer)
                {
                    Caption = 'Transfer';
                    field("Transfer-from Code HEADER"; TransferFromCodeField)
                    {
                        CaptionML = ENU = 'Transfer-from Code', ENG = 'Transfer-from Code', ESP = 'Transfer. desde Cód.';
                        ApplicationArea = Planning;
                        ToolTip = 'Specifies the code of the location that items are transferred from.';
                        TableRelation = Location;
                    }
                }
                group(Assembly)
                {
                    CaptionML = ENU = 'Assembly', ENG = 'Assembly', ESP = 'Ensamblado';
                    field("Assembly Policy HEADER"; AssemblyPolicyField)
                    {
                        CaptionML = ENU = 'Assembly Policy', ENG = 'Assembly Policy', ESP = 'Directiva de Ensamblado';
                        ApplicationArea = Assembly;
                        ToolTip = 'Specifies which default order flow is used to supply this SKU by assembly.';
                    }
                }
                group(Production)
                {
                    CaptionML = ENU = 'Production', ENG = 'Production', ESP = 'Producción';
                    field("Manufacturing Policy HEADER"; ManufacturingPolicyField)
                    {
                        CaptionML = ENU = 'Manufacturing Policy', ENG = 'Manufacturing Policy', ESP = 'Directiva de Fabricación';
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies if additional orders for any related components are calculated.';
                    }
                    field("Flushing Method HEADER"; FlushingMethodField)
                    {
                        CaptionML = ENU = 'Flushing Method', ENG = 'Flushing Method', ESP = 'Método de baja';
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies how consumption of the item (component) is calculated and handled in production processes. Manual: Enter and post consumption in the consumption journal manually. Forward: Automatically posts consumption according to the production order component lines when the first operation starts. Backward: Automatically calculates and posts consumption according to the production order component lines when the production order is finished. Pick + Forward / Pick + Backward: Variations with warehousing.';
                    }
                    field("Components at Location HEADER"; ComponentsAtLocationField)
                    {
                        CaptionML = ENU = 'Components at Location', ENG = 'Components at Location', ESP = 'Componentes en Almacén';
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies the inventory location from where the production order components are to be taken when producing this SKU.';
                        TableRelation = Location;
                    }
                    field("Lot Size HEADER"; LotSizeField)
                    {
                        CaptionML = ENU = 'Lot Size', ENG = 'Lot Size', ESP = 'Tamaño de Lote';
                        ApplicationArea = Manufacturing;
                        ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                        DecimalPlaces = 0 : 5;
                        MinValue = -1;
                    }
                    /*  field("Routing No. HEADER"; Rec."Routing No.")
                     {
                         ApplicationArea = Manufacturing;
                         ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                     } */
                    /*  field("Production BOM No. HEADER"; Rec."Production BOM No.")
                     {
                         ApplicationArea = Manufacturing;
                         ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                     } */
                }
            }
            group(Planning)
            {
                CaptionML = ENU = 'Planning', ENG = 'Planning', ESP = 'Planificación';
                field("Reordering Policy HEADER"; ReorderingPolicyField)
                {
                    CaptionML = ENU = 'Reordering Policy', ENG = 'Reordering Policy', ESP = 'Directiva Reaprov.';
                    ApplicationArea = Planning;
                    Importance = Promoted;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';

                    trigger OnValidate()
                    begin
                        EnablePlanningControls;
                    end;
                }
                field("Dampener Period HEADER"; DampenerPeriodField)
                {
                    CaptionML = ENU = 'Dampener Period', ENG = 'Dampener Period', ESP = 'Periodo amortiguador';
                    ApplicationArea = Planning;
                    Enabled = DampenerPeriodEnable;
                    ToolTip = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward. The dampener period limits the number of insignificant rescheduling of existing supply to a later date if that new date is within the dampener period. The dampener period function is only initiated if the supply can be rescheduled to a later date and not if the supply can be rescheduled to an earlier date. Accordingly, if the suggested new supply date is after the dampener period, then the rescheduling suggestion is not blocked. If the lot accumulation period is less than the dampener period, then the dampener period is dynamically set to equal the lot accumulation period. This is not shown in the value that you enter in the Dampener Period field. The last demand in the lot accumulation period is used to determine whether a potential supply date is in the dampener period. If this field is empty, then the value in the Default Dampener Period field in the Manufacturing Setup window applies. The value that you enter in the Dampener Period field must be a date formula, and one day (1D) is the shortest allowed period.';
                    trigger OnValidate()
                    begin
                        CalendarMgt.CheckDateFormulaPositive(DampenerPeriodField);
                    end;
                }
                field("Dampener Quantity HEADER"; DampenerQuantityField)
                {
                    CaptionML = ENU = 'Dampener Quantity', ENG = 'Dampener Quantity', ESP = 'Cantidad amortiguador';
                    ApplicationArea = Planning;
                    Enabled = DampenerQtyEnable;
                    ToolTip = 'Specifies a dampener quantity to block insignificant change suggestions, if the quantity by which the supply would change is lower than the dampener quantity.';
                    DecimalPlaces = 0 : 5;
                    MinValue = -1;
                }
                field("Safety Lead Time HEADER"; SafetyLeadtimeField)
                {
                    CaptionML = ENU = 'Safety Lead Time', ENG = 'Safety Lead Time', ESP = 'Plazo de seguridad';
                    ApplicationArea = Planning;
                    Enabled = SafetyLeadTimeEnable;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    trigger OnValidate()
                    begin
                        CalendarMgt.CheckDateFormulaPositive(SafetyLeadtimeField);
                    end;
                }
                field("Safety Stock Quantity HEADER"; SafetyStockQuantityField)
                {
                    CaptionML = ENU = 'Safety Stock Quantity', ENG = 'Safety Stock Quantity', ESP = 'Stock de Seguridad';
                    ApplicationArea = Planning;
                    Enabled = SafetyStockQtyEnable;
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    DecimalPlaces = 0 : 5;
                    MinValue = -1;
                }
                group("Lot-for-Lot Parameters")
                {
                    CaptionML = ENU = 'Lot-for-Lot Parameters', ENG = 'Lot-for-Lot Parameters', ESP = 'Parametros de Lote-a-lote';
                    field("Include Inventory HEADER"; IncludeInventoryField)
                    {
                        CaptionML = ENU = 'Include Inventory', ENG = 'Include Inventory', ESP = 'Incluir inventario';
                        ApplicationArea = Planning;
                        Enabled = IncludeInventoryEnable;
                        ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';

                        trigger OnValidate()
                        begin
                            EnablePlanningControls;
                        end;
                    }
                    field("Lot Accumulation Period HEADER"; LotAccumulationPeriodField)
                    {
                        CaptionML = ENU = 'Lot Accumulation Period', ENG = 'Lot Accumulation Period', ESP = 'Periodo acumulación de lotes';
                        ApplicationArea = Planning;
                        Enabled = LotAccumulationPeriodEnable;
                        ToolTip = 'Specifies a period in which multiple demands are accumulated into one supply order when you use the Lot-for-Lot reordering policy.';
                        trigger OnValidate()
                        begin
                            CalendarMgt.CheckDateFormulaPositive(LotAccumulationPeriodField);
                        end;
                    }
                    field("Rescheduling Period HEADER"; ReschedulingPeriodField)
                    {
                        CaptionML = ENU = 'Rescheduling Period', ENG = 'Rescheduling Period', ESP = 'Periodo de Reprogramación';
                        ApplicationArea = Planning;
                        Enabled = ReschedulingPeriodEnable;
                        ToolTip = 'Specifies a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.';
                        trigger OnValidate()
                        begin
                            CalendarMgt.CheckDateFormulaPositive(ReschedulingPeriodField);
                        end;
                    }
                }
                group("Reorder-Point Parameters")
                {
                    CaptionML = ENU = 'Reorder-Point Parameters', ENG = 'Reorder-Point Parameters', ESP = 'Parámetros de punto pedido';
                    grid(Control39)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control41)
                        {
                            ShowCaption = false;
                            field("Reorder Point HEADER"; ReorderPointField)
                            {
                                CaptionML = ENU = 'Reorder Point', ENG = 'Reorder Point', ESP = 'Punto pedido';
                                ApplicationArea = Planning;
                                Enabled = ReorderPointEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                            }
                            field("Reorder Quantity HEADER"; ReorderQuantityField)
                            {
                                CaptionML = ENU = 'Reorder Quantity', ENG = 'Reorder Quantity', ESP = 'Cantidad a pedir';
                                ApplicationArea = Planning;
                                Enabled = ReorderQtyEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                            }
                            field("Maximum Inventory HEADER"; MaximumInventoryField)
                            {
                                CaptionML = ENU = 'Maximum Inventory', ENG = 'Maximum Inventory', ESP = 'Stock máximo';
                                ApplicationArea = Planning;
                                Enabled = MaximumInventoryEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                            }
                        }
                    }
                    field("Overflow Level HEADER"; OverflowLevelField)
                    {
                        CaptionML = ENU = 'Overflow Level', ENG = 'Overflow Level', ESP = 'Nivel desbordamiento';
                        ApplicationArea = Planning;
                        Enabled = OverflowLevelEnable;
                        Importance = Additional;
                        ToolTip = 'Specifies a quantity you allow projected inventory to exceed the reorder point before the system suggests to decrease existing supply orders.';
                        DecimalPlaces = 0 : 5;
                        MinValue = -1;
                    }
                    field("Time Bucket HEADER"; TimeBucketField)
                    {
                        CaptionML = ENU = 'Time Bucket', ENG = 'Time Bucket', ESP = 'Ciclo';
                        ApplicationArea = Planning;
                        Enabled = TimeBucketEnable;
                        Importance = Additional;
                        ToolTip = 'Specifies a time period for the recurring planning horizon of the SKU when you use Fixed Reorder Qty. or Maximum Qty. reordering policies.';
                        trigger OnValidate()
                        begin
                            CalendarMgt.CheckDateFormulaPositive(TimeBucketField);
                        end;
                    }
                }
                group("Order Modifiers")
                {
                    CaptionML = ENU = 'Order Modifiers', ENG = 'Order Modifiers', ESP = 'Modificadores de Pedido';
                    Enabled = MinimumOrderQtyEnable;
                    grid(Control21)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control23)
                        {
                            ShowCaption = false;
                            field("Minimum Order Quantity HEADER"; MinimumOrderQuantityField)
                            {
                                CaptionML = ENU = 'Minimum Order Quantity', ENG = 'Minimum Order Quantity', ESP = 'Cantidad mínima de pedido';
                                ApplicationArea = Planning;
                                Enabled = MinimumOrderQtyEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                                MinValue = -1;
                            }
                            field("Maximum Order Quantity HEADER"; MaximumOrderQuantityField)
                            {
                                CaptionML = ENU = 'Maximum Order Quantity', ENG = 'Maximum Order Quantity', ESP = 'Cantidad máxima de pedido';
                                ApplicationArea = Planning;
                                Enabled = MaximumOrderQtyEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                                MinValue = -1;
                            }
                            field("Order Multiple HEADER"; OrderMultipleField)
                            {
                                CaptionML = ENU = 'Order Multiple', ENG = 'Order Multiple', ESP = 'Múltiplos de Pedido';
                                ApplicationArea = Planning;
                                Enabled = OrderMultipleEnable;
                                ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                                DecimalPlaces = 0 : 5;
                                MinValue = -1;
                            }
                        }
                    }
                }
            }

            repeater(SKUs)
            {
                CaptionML = ENU = 'SKU''s to modify', ENG = 'SKU''s to modify', ESP = 'SKUs a modificar';
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item number to which the SKU applies.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the variant of the item on the line.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the location code (for example, the warehouse or distribution center) to which the SKU applies.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ToolTip = 'Specifies the type of supply order that is created by the planning system when the SKU needs to be replenished.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ToolTip = 'Specifies the code of the location that items are transferred from.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    ToolTip = 'Specifies if additional orders for any related components are calculated.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ToolTip = 'Specifies how consumption of the item (component) is calculated and handled in production processes. Manual: Enter and post consumption in the consumption journal manually. Forward: Automatically posts consumption according to the production order component lines when the first operation starts. Backward: Automatically calculates and posts consumption according to the production order component lines when the production order is finished. Pick + Forward / Pick + Backward: Variations with warehousing.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Components at Location"; Rec."Components at Location")
                {
                    ToolTip = 'Specifies the inventory location from where the production order components are to be taken when producing this SKU.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lot Size"; Rec."Lot Size")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    ToolTip = 'Specifies which default order flow is used to supply this SKU by assembly.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dampener Period"; Rec."Dampener Period")
                {
                    ToolTip = 'Specifies a period of time during which you do not want the planning system to propose to reschedule existing supply orders forward. The dampener period limits the number of insignificant rescheduling of existing supply to a later date if that new date is within the dampener period. The dampener period function is only initiated if the supply can be rescheduled to a later date and not if the supply can be rescheduled to an earlier date. Accordingly, if the suggested new supply date is after the dampener period, then the rescheduling suggestion is not blocked. If the lot accumulation period is less than the dampener period, then the dampener period is dynamically set to equal the lot accumulation period. This is not shown in the value that you enter in the Dampener Period field. The last demand in the lot accumulation period is used to determine whether a potential supply date is in the dampener period. If this field is empty, then the value in the Default Dampener Period field in the Manufacturing Setup window applies. The value that you enter in the Dampener Period field must be a date formula, and one day (1D) is the shortest allowed period.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dampener Quantity"; Rec."Dampener Quantity")
                {
                    ToolTip = 'Specifies a dampener quantity to block insignificant change suggestions, if the quantity by which the supply would change is lower than the dampener quantity.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lot Accumulation Period"; Rec."Lot Accumulation Period")
                {
                    ToolTip = 'Specifies a period in which multiple demands are accumulated into one supply order when you use the Lot-for-Lot reordering policy.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rescheduling Period"; Rec."Rescheduling Period")
                {
                    ToolTip = 'Specifies a period within which any suggestion to change a supply date always consists of a Reschedule action and never a Cancel + New action.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Overflow Level"; Rec."Overflow Level")
                {
                    ApplicationArea = Planning;
                    Enabled = OverflowLevelEnable;
                    Importance = Additional;
                    ToolTip = 'Specifies a quantity you allow projected inventory to exceed the reorder point before the system suggests to decrease existing supply orders.';
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    ApplicationArea = Planning;
                    Enabled = TimeBucketEnable;
                    Importance = Additional;
                    ToolTip = 'Specifies a time period for the recurring planning horizon of the SKU when you use Fixed Reorder Qty. or Maximum Qty. reordering policies.';
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ToolTip = 'Specifies for the SKU, the same as the field does on the item card.';
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
                ApplicationArea = Planning;
                CaptionML = ENU = 'Process Update', ENG = 'Process Update', ESP = 'Procesar Actualización';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    MassUpdateMgt: Codeunit "DVC MassUpdate Mgt.";
                begin
                    MassUpdateMgt.UpdateMassive(SKUReplenishmentSystemField, LeadtimecalculationField, TransferFromCodeField, AssemblyPolicyField, ManufacturingPolicyField, FlushingMethodField,
                                            ComponentsAtLocationField, LotSizeField, ReorderingPolicyField, DampenerPeriodField, DampenerQuantityField, SafetyLeadtimeField, SafetyStockQuantityField, IncludeInventoryField,
                                            LotAccumulationPeriodField, ReschedulingPeriodField, ReorderPointField, ReorderQuantityField, MaximumInventoryField, OverflowLevelField, TimeBucketField, MinimumOrderQuantityField, MaximumOrderQuantityField, OrderMultipleField, Rec);
                end;
            }
        }
    }
    var
        CalendarMgt: Codeunit "Calendar Management";
        SKUReplenishmentSystemField: Enum "SKU Replenishment System";
        LeadtimecalculationField: DateFormula;
        TransferFromCodeField: code[20];
        AssemblyPolicyField: Enum "Assembly Policy";
        ManufacturingPolicyField: Enum "Manufacturing Policy";
        FlushingMethodField: Enum "Flushing Method";
        ComponentsAtLocationField: Code[20];
        LotSizeField: Decimal;
        ReorderingPolicyField: Enum "Reordering Policy";
        DampenerPeriodField: DateFormula;
        DampenerQuantityField: Decimal;
        SafetyLeadtimeField: DateFormula;
        SafetyStockQuantityField: Decimal;
        IncludeInventoryField: Boolean;
        LotAccumulationPeriodField: DateFormula;
        ReschedulingPeriodField: DateFormula;
        ReorderPointField: Decimal;
        ReorderQuantityField: Decimal;
        MaximumInventoryField: Decimal;
        OverflowLevelField: Decimal;
        TimeBucketField: DateFormula;
        MinimumOrderQuantityField: Decimal;
        MaximumOrderQuantityField: Decimal;
        OrderMultipleField: Decimal;

        [InDataSet]
        MinimumOrderQtyEnable: Boolean;
        [InDataSet]
        MaximumOrderQtyEnable: Boolean;
        [InDataSet]
        TimeBucketEnable: Boolean;
        [InDataSet]
        OverflowLevelEnable: Boolean;
        [InDataSet]
        OrderMultipleEnable: Boolean;
        [InDataSet]
        ReorderPointEnable: Boolean;
        [InDataSet]
        ReorderQtyEnable: Boolean;
        [InDataSet]
        MaximumInventoryEnable: Boolean;
        [InDataSet]
        ReschedulingPeriodEnable: Boolean;
        [InDataSet]
        LotAccumulationPeriodEnable: Boolean;
        [InDataSet]
        DampenerPeriodEnable: Boolean;
        [InDataSet]
        DampenerQtyEnable: Boolean;
        [InDataSet]
        SafetyLeadTimeEnable: Boolean;
        [InDataSet]
        SafetyStockQtyEnable: Boolean;
        [InDataSet]
        IncludeInventoryEnable: Boolean;

    trigger OnInit()
    begin
        OverflowLevelEnable := true;
        DampenerQtyEnable := true;
        DampenerPeriodEnable := true;
        LotAccumulationPeriodEnable := true;
        ReschedulingPeriodEnable := true;
        IncludeInventoryEnable := true;
        OrderMultipleEnable := true;
        MaximumOrderQtyEnable := true;
        MinimumOrderQtyEnable := true;
        MaximumInventoryEnable := true;
        ReorderQtyEnable := true;
        ReorderPointEnable := true;
        SafetyStockQtyEnable := true;
        SafetyLeadTimeEnable := true;
        TimeBucketEnable := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EnablePlanningControls();
    end;

    local procedure EnablePlanningControls()
    var
        PlanningParameters: Record "Planning Parameters";
        PlanningGetParameters: Codeunit "Planning-Get Parameters";
    begin
        PlanningParameters."Reordering Policy" := ReorderingPolicyField;
        PlanningParameters."Include Inventory" := IncludeInventoryField;
        PlanningGetParameters.SetPlanningParameters(PlanningParameters);

        TimeBucketEnable := PlanningParameters."Time Bucket Enabled";
        SafetyLeadTimeEnable := PlanningParameters."Safety Lead Time Enabled";
        SafetyStockQtyEnable := PlanningParameters."Safety Stock Qty Enabled";
        ReorderPointEnable := PlanningParameters."Reorder Point Enabled";
        ReorderQtyEnable := PlanningParameters."Reorder Quantity Enabled";
        MaximumInventoryEnable := PlanningParameters."Maximum Inventory Enabled";
        MinimumOrderQtyEnable := PlanningParameters."Minimum Order Qty Enabled";
        MaximumOrderQtyEnable := PlanningParameters."Maximum Order Qty Enabled";
        OrderMultipleEnable := PlanningParameters."Order Multiple Enabled";
        IncludeInventoryEnable := PlanningParameters."Include Inventory Enabled";
        ReschedulingPeriodEnable := PlanningParameters."Rescheduling Period Enabled";
        LotAccumulationPeriodEnable := PlanningParameters."Lot Accum. Period Enabled";
        DampenerPeriodEnable := PlanningParameters."Dampener Period Enabled";
        DampenerQtyEnable := PlanningParameters."Dampener Quantity Enabled";
        OverflowLevelEnable := PlanningParameters."Overflow Level Enabled";
    end;
}
