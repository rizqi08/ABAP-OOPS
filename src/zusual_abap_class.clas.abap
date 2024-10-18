class ZUSUAL_ABAP_CLASS definition
  public
  final
  create public .

public section.

  class-methods DISPLAY
    importing
      !PVBELN type VBELN_VA
    exporting
      !PERDAT type ERDAT
      !PERZET type ERZET
      !PERNAM type ERNAM
      !PVBTYP type VBTYP
    exceptions
      WRONG_INPUT .
protected section.
private section.
ENDCLASS.



CLASS ZUSUAL_ABAP_CLASS IMPLEMENTATION.


  method DISPLAY.
    SELECT SINGLE ERDAT ERZET ERNAM VBTYP
    FROM VBAK
    INTO (PERDAT, PERZET, PERNAM, PVBTYP)
    WHERE VBELN = PVBELN.

    IF SY-SUBRC <> 0.
      RAISE WRONG_INPUT.
    ENDIF.
  endmethod.
ENDCLASS.
