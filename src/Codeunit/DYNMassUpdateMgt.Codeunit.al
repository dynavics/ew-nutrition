codeunit 62700 "DVC MassUpdate Mgt."
{

    procedure OpenMassUpdate(var StockkeepingUnit: Record "Stockkeeping Unit")
    var
        MassUpdate: page "DVC Mass Update";
    begin
        Clear(MassUpdate);
        MassUpdate.SetTableView(StockkeepingUnit);
        MassUpdate.RunModal();
    end;

    procedure UpdateMassive(SKUReplenishmentSystemField: Enum "SKU Replenishment System"; LeadtimecalculationField: DateFormula; TransferFromCodeField: code[20]; AssemblyPolicyField: Enum "Assembly Policy"; ManufacturingPolicyField: Enum "Manufacturing Policy"; FlushingMethodField: Enum "Flushing Method";
        ComponentsAtLocationField: Code[20]; LotSizeField: Decimal; ReorderingPolicyField: Enum "Reordering Policy"; DampenerPeriodField: DateFormula; DampenerQuantityField: Decimal; SafetyLeadtimeField: DateFormula; SafetyStockQuantityField: Decimal; IncludeInventoryField: Boolean;
        LotAccumulationPeriodField: DateFormula; ReschedulingPeriodField: DateFormula; ReorderPointField: Decimal; ReorderQuantityField: Decimal; MaximumInventoryField: Decimal; OverflowLevelField: Decimal; TimeBucketField: DateFormula; MinimumOrderQuantityField: Decimal; MaximumOrderQuantityField: Decimal; OrderMultipleField: Decimal; var StockkeepingUnit: Record "Stockkeeping Unit")
    var
        Text001: TextConst ENU = 'You are going to update %1 SKU''s, are you sure?', ENG = 'You are going to update %1 SKU''s, are you sure?', ESP = 'Va a actualizar %1 SKU''s, ¿Está seguro?';
        Text002: TextConst ENU = 'There aren''t SKU''s in the selected filter', ENG = 'There aren''t SKU''s in the selected filter', ESP = 'No hay SKU''s en el filtro seleccionado';
        Text003: TextConst ENU = 'process finished successfully', ENG = 'process finished successfully', ESP = 'Proceso finalizado correctamente';

    begin
        if StockkeepingUnit.FindSet() then begin
            if not confirm(StrSubstNo(Text001, Format(StockkeepingUnit.Count))) then
                exit;
            repeat
                ProcessUpdateMassive(SKUReplenishmentSystemField, LeadtimecalculationField, TransferFromCodeField, AssemblyPolicyField, ManufacturingPolicyField, FlushingMethodField,
                                           ComponentsAtLocationField, LotSizeField, ReorderingPolicyField, DampenerPeriodField, DampenerQuantityField, SafetyLeadtimeField, SafetyStockQuantityField, IncludeInventoryField,
                                           LotAccumulationPeriodField, ReschedulingPeriodField, ReorderPointField, ReorderQuantityField, MaximumInventoryField, OverflowLevelField, TimeBucketField, MinimumOrderQuantityField, MaximumOrderQuantityField, OrderMultipleField, StockkeepingUnit);
            until StockkeepingUnit.Next() = 0;
            Message(Text003)
        end else
            Error(Text002);
    end;


    local procedure ProcessUpdateMassive(SKUReplenishmentSystemField: Enum "SKU Replenishment System"; LeadtimecalculationField: DateFormula; TransferFromCodeField: code[20]; AssemblyPolicyField: Enum "Assembly Policy"; ManufacturingPolicyField: Enum "Manufacturing Policy"; FlushingMethodField: Enum "Flushing Method";
            ComponentsAtLocationField: Code[20]; LotSizeField: Decimal; ReorderingPolicyField: Enum "Reordering Policy"; DampenerPeriodField: DateFormula; DampenerQuantityField: Decimal; SafetyLeadtimeField: DateFormula; SafetyStockQuantityField: Decimal; IncludeInventoryField: Boolean;
            LotAccumulationPeriodField: DateFormula; ReschedulingPeriodField: DateFormula; ReorderPointField: Decimal; ReorderQuantityField: Decimal; MaximumInventoryField: Decimal; OverflowLevelField: Decimal; TimeBucketField: DateFormula; MinimumOrderQuantityField: Decimal; MaximumOrderQuantityField: Decimal; OrderMultipleField: Decimal; var StockkeepingUnit: Record "Stockkeeping Unit")
    begin

        StockkeepingUnit.Validate("Replenishment System", SKUReplenishmentSystemField);
        StockkeepingUnit.Validate("Lead Time Calculation", LeadtimecalculationField);
        StockkeepingUnit.Validate("Transfer-from Code", TransferFromCodeField);
        StockkeepingUnit.Validate("Assembly Policy", AssemblyPolicyField);
        StockkeepingUnit.Validate("Manufacturing Policy", ManufacturingPolicyField);
        StockkeepingUnit.Validate("Flushing Method", FlushingMethodField);
        StockkeepingUnit.Validate("Components at Location", ComponentsAtLocationField);
        StockkeepingUnit.Validate("Lot Size", LotSizeField);
        StockkeepingUnit.Validate("Reordering Policy", ReorderingPolicyField);
        StockkeepingUnit.Validate("Dampener Period", DampenerPeriodField);
        StockkeepingUnit.Validate("Dampener Quantity", DampenerQuantityField);
        StockkeepingUnit.Validate("Safety Lead Time", SafetyLeadtimeField);
        StockkeepingUnit.Validate("Safety Stock Quantity", SafetyStockQuantityField);
        StockkeepingUnit.Validate("Include Inventory", IncludeInventoryField);
        StockkeepingUnit.Validate("Lot Accumulation Period", LotAccumulationPeriodField);
        StockkeepingUnit.Validate("Rescheduling Period", ReschedulingPeriodField);
        StockkeepingUnit.Validate("Reorder Point", ReorderPointField);
        StockkeepingUnit.Validate("Reorder Point", ReorderQuantityField);
        StockkeepingUnit.Validate("Maximum Inventory", MaximumInventoryField);
        StockkeepingUnit.Validate("Overflow Level", OverflowLevelField);
        StockkeepingUnit.Validate("Time Bucket", TimeBucketField);
        StockkeepingUnit.Validate("Minimum Order Quantity", MinimumOrderQuantityField);
        StockkeepingUnit.Validate("Maximum Order Quantity", MaximumOrderQuantityField);
        StockkeepingUnit.Validate("Order Multiple", OrderMultipleField);

        StockkeepingUnit.Modify(true);
    end;

    procedure OpenCreateSKUs(var Item: Record Item)
    var
        CreateSKU: Page "DVC Create SKU";
    begin
        Clear(CreateSKU);
        CreateSKU.SetTableView(Item);
        CreateSKU.RunModal();
    end;

    procedure CreateSKUs(var Item: Record Item; var Location: Record Location)
    var
        Text001: TextConst ENU = 'You are going to create %1 SKU''s, are you sure?', ENG = 'You are going to create %1 SKU''s, are you sure?', ESP = 'Va a crear %1 SKU''s, ¿Está seguro?';
        Text002: TextConst ENU = 'There aren''t items in the selected filter', ENG = 'There aren''t items in the selected filter', ESP = 'No hay productos en el filtro seleccionado';
        Text003: TextConst ENU = 'There aren''t locations in the selected filter', ENG = 'There aren''t locations in the selected filter', ESP = 'No hay almacenes en el filtro seleccionado';
        Text004: TextConst ENU = 'Process finished successfully. Created %1 SKUs, omited %2 SKUs.', ENG = 'process finished successfully. Created %1 SKUs, omited %2 SKUs.', ESP = 'Proceso finalizado correctamente. Creadas %1 SKUs, omitidas %2 SKUs.';
        Counter: Integer;
        TotalSKUs: Integer;

    begin
        if not item.FindSet() then
            Error(text002);

        if not Location.FindSet() then
            Error(Text003);

        TotalSKUs := Item.Count * Location.Count;

        if not confirm(StrSubstNo(Text001, Format(TotalSKUs))) then
            exit;

        Counter := 0;

        if item.FindSet() then begin
            repeat

                if Location.FindSet() then
                    repeat
                        if not ProcessCreateSKU(item, Location.Code) then
                            Counter += 1;
                    until Location.Next() = 0;
            until item.Next() = 0;

            Message(StrSubstNo(Text004, format(TotalSKUs - Counter), Format(Counter)));
        end;
    end;


    local procedure ProcessCreateSKU(var Item2: Record Item; LocationCode: Code[10]): Boolean
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        StockkeepingUnit.Init();
        StockkeepingUnit."Item No." := Item2."No.";
        StockkeepingUnit."Location Code" := LocationCode;
        StockkeepingUnit."Variant Code" := '';
        StockkeepingUnit.CopyFromItem(Item2);
        StockkeepingUnit."Last Date Modified" := WorkDate;
        StockkeepingUnit."Special Equipment Code" := Item2."Special Equipment Code";
        StockkeepingUnit."Put-away Template Code" := Item2."Put-away Template Code";
        StockkeepingUnit.SetHideValidationDialog(true);
        StockkeepingUnit.Validate("Phys Invt Counting Period Code", Item2."Phys Invt Counting Period Code");
        StockkeepingUnit."Put-away Unit of Measure Code" := Item2."Put-away Unit of Measure Code";
        StockkeepingUnit."Use Cross-Docking" := Item2."Use Cross-Docking";
        if not StockkeepingUnit.Insert(true) then begin
            exit(false);
        end;
        exit(true);
    end;

    procedure SelectSKUs(var Item: Record Item; var Location: Record Location; var StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        StockkeepingUnit.ClearMarks();
        if item.FindSet() then
            repeat
                if Location.FindSet() then
                    repeat
                        StockkeepingUnit.SetRange("Item No.", item."No.");
                        StockkeepingUnit.SetRange("Location Code", Location.Code);
                        if StockkeepingUnit.FindFirst() then begin
                            //Message('Found');
                            StockkeepingUnit.Mark(true);
                        end;
                    until Location.Next() = 0;
            until item.Next() = 0;
        StockkeepingUnit.SetRange("Item No.");
        StockkeepingUnit.SetRange("Location Code");
        StockkeepingUnit.MarkedOnly(true);

    end;


}
