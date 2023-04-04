There are several DAX functions that are relevant to model relationships.

## RELATED

The [RELATED](/dax/related-function-dax) function retrieves the value from "one" side of a relationship. It’s useful when involving calculations from different tables that are evaluated in row context.

> [!TIP]
> To learn more about row context, work through the [Add calculated tables and columns to Power BI Desktop models](/training/modules/dax-power-bi-add-calculated-tables/) module. While this module describes adding model calculations, it includes a unit that introduces and describes row context.

## RELATEDTABLE

The [RELATEDTABLE](/dax/relatedtable-function-dax) function retrieves a table of rows from the "many" side of a relationship.

## USERELATIONSHIP

The [USERELATIONSHIP](/dax/userelationship-function-dax) function forces the use of a specific inactive model relationship. It’s useful when your model includes a role-playing dimension table, and you choose to create inactive relationships from this table.

For more information, see [Active vs inactive relationship guidance](/power-bi/guidance/relationships-active-inactive).

## CROSSFILTER

The [CROSSFILTER](/dax/crossfilter-function) function either modifies the relationship cross filter direction (to one or both), or it disables filter propagation (none). It’s useful when you need to change or ignore model relationships during the evaluation of a specific calculation.

## COMBINEVALUES

The [COMBINEVALUES](/dax/combinevalues-function-dax) function joins two or more text strings into one text string. The purpose of this function is to support multi-column relationships in DirectQuery models when tables belong to the same source group.

## TREATAS

The [TREATAS](/dax/treatas-function) function applies the result of a table expression as filters to columns from an unrelated table. It’s helpful in advanced scenarios when you want to create a virtual relationship during the evaluation of a specific calculation.

## Parent and child functions

The [Parent and child functions](/dax/parent-and-child-functions-dax) are a family of related functions that you can use to generate calculated columns to naturalize a parent-child hierarchy. You can then use these columns to create a fixed-level hierarchy.

For more information, see [Understanding functions for parent-child hierarchies in DAX](/dax/understanding-functions-for-parent-child-hierarchies-in-dax).