class ZCLASS_10 definition
  public
  create public .

public section.

  methods DISPLAY
    importing
      !PVBELN type VBELN_VA
    exporting
      !PERDAT type ERDAT
      !PERZET type ERZET
      !PERNAM type ERNAM
      !PVBTYP type VBTYP .
protected section.
private section.
ENDCLASS.



CLASS ZCLASS_10 IMPLEMENTATION.


  method DISPLAY.
  endmethod.
ENDCLASS.