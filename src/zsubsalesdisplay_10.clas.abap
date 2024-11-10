class ZSUBSALESDISPLAY_10 definition
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



CLASS ZSUBSALESDISPLAY_10 IMPLEMENTATION.


  METHOD DISPLAY.
    SELECT SINGLE ERDAT ERZET ERNAM VBTYP
    FROM VBAK
    INTO (PERDAT, PERZET, PERNAM, PVBTYP)
    WHERE VBELN = PVBELN.
  ENDMETHOD.
ENDCLASS.
