class ZSUBBILLINGDISPLAY_10 definition
  public
  inheriting from ZABSTRACTCLASS_10
  final
  create public .

public section.

  methods DISPLAY
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZSUBBILLINGDISPLAY_10 IMPLEMENTATION.


  method DISPLAY.
    select single vbtyp ernam erzet erdat
    from vbrk
    into (pvbtyp, pernam, perzet, perdat)
    where vbeln = pvbeln.
  endmethod.
ENDCLASS.
