*----------------------------------------------------------------------*
*       CLASS ZCL_NEPTUNE_DEMO_APPEARANCE DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class zcl_neptune_demo_appearance definition
  public
  final
  create public .

*"* public components of class ZCL_NEPTUNE_DEMO_APPEARANCE
*"* do not include other source files here!!!
  public section.

    interfaces /neptune/if_nad_server .

    types:
      begin of ty_menu,
          tile_title       type string,
          tile_info        type string,
          tile_footer      type string,
          tile_number      type string,
          tile_unit        type string,
          tile_infostate   type string,
          tile_indicator   type string,
          tile_valuecolor  type string,
          tile_value1      type string,
          tile_value2      type string,
          tile_value3      type string,
          tile_color1      type string,
          tile_color2      type string,
          tile_color3      type string,
          tile_title1      type string,
          tile_title2      type string,
          tile_title3      type string,
          tile_scale       type string,
          tile_details     type string,
          tile_sidetitle1  type string,
          tile_sidenumber1 type string,
          tile_sideunit1   type string,
          tile_sidetitle2  type string,
          tile_sidenumber2 type string,
          tile_sideunit2   type string,
          tile_icon        type string,
          tile_disp_value1 type string,
          tile_disp_value2 type string,
          tile_disp_value3 type string,
        end of ty_menu .

    data gs_menu type ty_menu .

    class-methods randomize
      returning
        value(menu) type ty_menu .
protected section.

  data AJAX_VALUE type STRING .
  data SERVER type ref to /NEPTUNE/CL_NAD_SERVER .
  data REQUEST type /NEPTUNE/DATA_REQUEST .
  data APPLID type STRING .
  data AJAX_ID type STRING .
  data NAVIGATION type /NEPTUNE/AJAX_NAVIGATION .
  data RETURN type /NEPTUNE/AJAX_RETURN .

  methods BULLET .
  methods COLUMN .
  methods RADIAL .
*"* protected components of class ZCL_NEPTUNE_DEMO_APPEARANCE
*"* do not include other source files here!!!
  methods COMPARISON .
  methods DELTA .
  methods HARVEY .
  methods NUMBER .
  methods DB_READ .
  methods DB_UPDATE .
  methods NUMERIC .
  methods NUMERIC_DB .
  private section.
*"* private components of class ZCL_NEPTUNE_DEMO_APPEARANCE
*"* do not include other source files here!!!

    class-methods get_random_data
      returning
        value(wa_menu) type ty_menu .

ENDCLASS.



CLASS ZCL_NEPTUNE_DEMO_APPEARANCE IMPLEMENTATION.


  method /neptune/if_nad_server~handle_on_ajax.

    data lx_dyn_call type ref to cx_sy_dyn_call_illegal_method.

    if ajax_id is not initial.

      me->applid = applid.
      me->ajax_id = ajax_id.
      me->ajax_value = ajax_value.
      me->navigation = navigation.
      me->server = server.
      me->request = request.

      try.
          call method me->(ajax_id).
          return = me->return.

        catch cx_sy_dyn_call_illegal_method into lx_dyn_call.

          return-status_code = 501.
          return-status_text = 'Not Implemented'.
          message e002(/neptune/xhr) with ajax_id into return-response_text.

      endtry.

    endif.

  endmethod.                    "/NEPTUNE/IF_NAD_SERVER~HANDLE_ON_AJAX


method bullet.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  server->api_tile_info(
    exporting
      value1      = gs_menu-tile_value1
      value2      = gs_menu-tile_value2
      value3      = gs_menu-tile_value3
      color1      = gs_menu-tile_color1
      color2      = gs_menu-tile_color2
      color3      = gs_menu-tile_color3
  ).

endmethod.


method column.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  server->api_tile_info(
    exporting
       number      = '120'
       title1      = gs_menu-tile_title
       value1      = gs_menu-tile_value1
       value2      = gs_menu-tile_value2
       value3      = gs_menu-tile_value3
       color1      = gs_menu-tile_color1
       color2      = gs_menu-tile_color2
       color3      = gs_menu-tile_color3
       valuecolor  = gs_menu-tile_valuecolor
  ).

endmethod.


method comparison.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  concatenate gs_menu-tile_value1 '%' into gs_menu-tile_disp_value1.
  concatenate gs_menu-tile_value2 '%' into gs_menu-tile_disp_value2.
  concatenate gs_menu-tile_value3 '%' into gs_menu-tile_disp_value3.

  server->api_tile_info(
    exporting
      title1         = 'Europe'
      title2         = 'USA'
      title3         = 'Asia'
      value1         = gs_menu-tile_value1
      value2         = gs_menu-tile_value2
      value3         = gs_menu-tile_value3
      display_value1 = gs_menu-tile_disp_value1
      display_value2 = gs_menu-tile_disp_value2
      display_value3 = gs_menu-tile_disp_value3
      color1         = gs_menu-tile_color1
      color2         = gs_menu-tile_color2
      color3         = gs_menu-tile_color3
  ).

endmethod.


  method db_read.

    data ls_dynamic type zneptune_dynamic.

    select single *
      into ls_dynamic
      from zneptune_dynamic
      where applid eq 'NEPTUNE'.

    if sy-subrc = 0.

      gs_menu-tile_title       = ls_dynamic-title.
      gs_menu-tile_info        = ls_dynamic-info.
      gs_menu-tile_icon        = ls_dynamic-icon.
      gs_menu-tile_footer      = ls_dynamic-footer.
      gs_menu-tile_number      = ls_dynamic-tile_number.
      gs_menu-tile_unit        = ls_dynamic-unit.
      gs_menu-tile_indicator   = ls_dynamic-tile_indicator.
      gs_menu-tile_valuecolor  = ls_dynamic-valuecolor.
      gs_menu-tile_scale       = ls_dynamic-scale.
      gs_menu-tile_details     = ls_dynamic-details.
      gs_menu-tile_sidetitle1  = ls_dynamic-side_title1.
      gs_menu-tile_sidenumber1 = ls_dynamic-side_number1.
      gs_menu-tile_sideunit1   = ls_dynamic-side_unit1.
      gs_menu-tile_sidetitle2  = ls_dynamic-side_title2.
      gs_menu-tile_sidenumber2 = ls_dynamic-side_number2.
      gs_menu-tile_sideunit2   = ls_dynamic-side_unit2.

    else.

      gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

    endif.

  endmethod.                    "db_read


  method db_update.

    data ls_dynamic type zneptune_dynamic.

    ls_dynamic-applid          = 'NEPTUNE'.
    ls_dynamic-title           = gs_menu-tile_title      .
    ls_dynamic-info            = gs_menu-tile_info       .
    ls_dynamic-icon            = gs_menu-tile_icon       .
    ls_dynamic-footer          = gs_menu-tile_footer     .
    ls_dynamic-tile_number     = gs_menu-tile_number     .
    ls_dynamic-unit            = gs_menu-tile_unit       .
    ls_dynamic-tile_indicator  = gs_menu-tile_indicator  .
    ls_dynamic-valuecolor      = gs_menu-tile_valuecolor .
    ls_dynamic-scale           = gs_menu-tile_scale      .
    ls_dynamic-details         = gs_menu-tile_details    .
    ls_dynamic-side_title1     = gs_menu-tile_sidetitle1 .
    ls_dynamic-side_number1    = gs_menu-tile_sidenumber1.
    ls_dynamic-side_unit1      = gs_menu-tile_sideunit1  .
    ls_dynamic-side_title2     = gs_menu-tile_sidetitle2 .
    ls_dynamic-side_number2    = gs_menu-tile_sidenumber2.
    ls_dynamic-side_unit2      = gs_menu-tile_sideunit2  .

    modify zneptune_dynamic from ls_dynamic.

  endmethod.                    "db_update


method DELTA.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  concatenate gs_menu-tile_value1 'NOK' into gs_menu-tile_disp_value1 separated by space.
  concatenate gs_menu-tile_value2 'NOK' into gs_menu-tile_disp_value2 separated by space.
  concatenate gs_menu-tile_value3 'NOK' into gs_menu-tile_disp_value3 separated by space.

  server->api_tile_info(
    exporting
      title1         = 'Europe'
      title2         = 'USA'
      value1         = gs_menu-tile_value1
      value2         = gs_menu-tile_value2
      value3         = gs_menu-tile_value3
      display_value1 = gs_menu-tile_disp_value1
      display_value2 = gs_menu-tile_disp_value2
      display_value3 = gs_menu-tile_disp_value3
      color1         = gs_menu-tile_color1
  ).

endmethod.


method get_random_data.

  data lv_prng type ref to cl_abap_random_int.
  data lv_seed type i.
  data lv_now type tzntstmpl.
  data lv_random_number type i.
  data lv_random1 type i.
  data lv_random2 type i.
  data lv_random3 type i.
  data lv_random4 type i.
  data lv_random5 type i.

  "Crate random numbers
  get time stamp field lv_now.
  lv_seed = frac( lv_now ) * 10000.

  "Number
  lv_prng = cl_abap_random_int=>create( seed = lv_seed min = -1000 max = 1000 ).
  lv_random_number = lv_prng->get_next( ).
  wa_menu-tile_number = lv_random_number.

  call function 'CLOI_PUT_SIGN_IN_FRONT'
    changing
      value = wa_menu-tile_number.

  if lv_random_number ge 300.
    wa_menu-tile_valuecolor = 'Good'.
    wa_menu-tile_indicator = 'Up'.
  elseif lv_random_number ge 100.
    wa_menu-tile_valuecolor = 'Neutral'.
    wa_menu-tile_indicator = 'None'.
  elseif lv_random_number ge -300.
    wa_menu-tile_valuecolor = 'Critical'.
    wa_menu-tile_indicator = 'Down'.
  else.
    wa_menu-tile_valuecolor = 'Error'.
    wa_menu-tile_indicator = 'Down'.
  endif.

  lv_prng = cl_abap_random_int=>create( seed = lv_seed min = 0 max = 100 ).

  wa_menu-tile_value1      = lv_prng->get_next( ).
  wa_menu-tile_value2      = lv_prng->get_next( ).
  wa_menu-tile_value3      = lv_prng->get_next( ).
  wa_menu-tile_sidenumber1 = lv_prng->get_next( ).
  wa_menu-tile_sidenumber2 = lv_prng->get_next( ).
  "Color1
  lv_prng    = cl_abap_random_int=>create( seed = lv_seed min = 0 max = 3 ).
  lv_random1 = lv_prng->get_next( ).
  lv_random2 = lv_prng->get_next( ).
  lv_random3 = lv_prng->get_next( ).
  lv_random4 = lv_prng->get_next( ).

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_sidetitle1 = 'Amount'.
    when '1'.
      wa_menu-tile_sidetitle1 = 'Supply'.
    when '2'.
      wa_menu-tile_sidetitle1 = 'Volume'.
    when '3'.
      wa_menu-tile_sidetitle1 = 'Load'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_sideunit1 = 'st'.
    when '1'.
      wa_menu-tile_sideunit1 = 'kg'.
    when '2'.
      wa_menu-tile_sideunit1 = 'lbr'.
    when '3'.
      wa_menu-tile_sideunit1 = 'pac'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_sidetitle2 = 'Target'.
    when '1'.
      wa_menu-tile_sidetitle2 = 'Goal'.
    when '2'.
      wa_menu-tile_sidetitle2 = 'Estimate'.
    when '3'.
      wa_menu-tile_sidetitle2 = 'Valuation'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_sideunit2 = 'USD'.
    when '1'.
      wa_menu-tile_sideunit2 = 'GBP'.
    when '2'.
      wa_menu-tile_sideunit2 = 'EUR'.
    when '3'.
      wa_menu-tile_sideunit2 = 'CHF'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_title = 'George Orwell'.
      wa_menu-tile_info = 'Animal Farm'.
    when '1'.
      wa_menu-tile_title = 'Dan Brown'.
      wa_menu-tile_info = 'The Da Vinci Code'.
    when '2'.
      wa_menu-tile_title = 'J.R.R. Tolkien'.
      wa_menu-tile_info = 'The Lord of the Rings'.
    when '3'.
      wa_menu-tile_title = 'Douglas Adams'.
      wa_menu-tile_info = `The Hitchhiker's Guide to the Galaxy`.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_icon = 'sap-icon://fas/crow'.
    when '1'.
      wa_menu-tile_icon = 'sap-icon://fas/dragon'.
    when '2'.
      wa_menu-tile_icon = 'sap-icon://fas/hippo'.
    when '3'.
      wa_menu-tile_icon = 'sap-icon://fas/frog'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_details = 'Those who realize their folly...'.
      wa_menu-tile_footer = '...are not true fools'.
    when '1'.
      wa_menu-tile_details = 'Life can only be understood backwards!'.
      wa_menu-tile_footer = '...but it must be lived forwards'.
    when '2'.
      wa_menu-tile_details = 'Keep your eyes on the stars...'.
      wa_menu-tile_footer = '...and your feet on the ground'.
    when '3'.
      wa_menu-tile_details = 'Meaning is a Jumper...'.
      wa_menu-tile_footer = '...that you have to knit yourself'.
  endcase.

  case lv_prng->get_next( ).
    when '0'.
      wa_menu-tile_scale = 'NOK'.
    when '1'.
      wa_menu-tile_scale = 'USD'.
    when '2'.
      wa_menu-tile_scale = 'EURO'.
    when '3'.
      wa_menu-tile_scale = 'YEN'.
  endcase.

  case lv_random1.

    when '0'.
      wa_menu-tile_color1 = 'Neutral'.

    when '1'.
      wa_menu-tile_color1 = 'Error'.

    when '2'.
      wa_menu-tile_color1 = 'Critical'.

    when '3'.
      wa_menu-tile_color1 = 'Good'.

  endcase.

  "Color2
  case lv_random2.

    when '0'.
      wa_menu-tile_color2 = 'Neutral'.

    when '1'.
      wa_menu-tile_color2 = 'Error'.

    when '2'.
      wa_menu-tile_color2 = 'Critical'.

    when '3'.
      wa_menu-tile_color2 = 'Good'.

  endcase.

  "Color3
  case lv_random3.

    when '0'.
      wa_menu-tile_color3 = 'Neutral'.

    when '1'.
      wa_menu-tile_color3 = 'Error'.

    when '2'.
      wa_menu-tile_color3 = 'Critical'.

    when '3'.
      wa_menu-tile_color3 = 'Good'.

  endcase.

endmethod.                    "get_random_data


method harvey.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  server->api_tile_info(
    exporting
       title1 = 'Sales'
       title3 = 'EUR'
       value1 = '120'
       value2 = gs_menu-tile_value2
       value3 = gs_menu-tile_value3
       color2 = gs_menu-tile_color2
  ).

endmethod.


method NUMBER.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  server->api_tile_info(
    exporting
      title                  = gs_menu-tile_title
      info                   = gs_menu-tile_info
      footer                 = gs_menu-tile_footer
      number                 = gs_menu-tile_number
      indicator              = gs_menu-tile_indicator
      valuecolor             = gs_menu-tile_valuecolor
      scale                  = gs_menu-tile_scale
      details                = gs_menu-tile_details
      side_indicator_title1  = gs_menu-tile_sidetitle1
      side_indicator_number1 = gs_menu-tile_sidenumber1
      side_indicator_unit1   = gs_menu-tile_sideunit1
      side_indicator_title2  = gs_menu-tile_sidetitle2
      side_indicator_number2 = gs_menu-tile_sidenumber2
      side_indicator_unit2   = gs_menu-tile_sideunit2
  ).

endmethod.


method numeric.

  data ls_tile_info  type /neptune/api_tile_info.
  data ls_tile_infox type /neptune/api_tile_infox.
  data lv_timestamp type string.
  data lv_tile_applid_params type string.

  split me->ajax_value at '||' into lv_timestamp lv_tile_applid_params.

  if 1 = 2.
    me->server->api_tile_info(
      no_frontend_update = abap_true
    ).

  else.

    gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

    ls_tile_info-title                  = gs_menu-tile_title.
    ls_tile_info-info                   = gs_menu-tile_info.
    ls_tile_info-icon                   = gs_menu-tile_icon.
    ls_tile_info-footer                 = gs_menu-tile_footer.
    ls_tile_info-number                 = gs_menu-tile_number.
    ls_tile_info-number_unit            = gs_menu-tile_unit.
    ls_tile_info-indicator              = gs_menu-tile_indicator.
    ls_tile_info-valuecolor             = gs_menu-tile_valuecolor.
    ls_tile_info-scale                  = gs_menu-tile_scale.
    ls_tile_info-details                = gs_menu-tile_details.
    ls_tile_info-side_indicator_title1  = gs_menu-tile_sidetitle1.
    ls_tile_info-side_indicator_number1 = gs_menu-tile_sidenumber1.
    ls_tile_info-side_indicator_unit1   = gs_menu-tile_sideunit1.
    ls_tile_info-side_indicator_title2  = gs_menu-tile_sidetitle2.
    ls_tile_info-side_indicator_number2 = gs_menu-tile_sidenumber2.
    ls_tile_info-side_indicator_unit2   = gs_menu-tile_sideunit2.

    ls_tile_infox-title                  = abap_true.
    ls_tile_infox-info                   = abap_true.
    ls_tile_infox-icon                   = abap_true.
    ls_tile_infox-footer                 = abap_true.
    ls_tile_infox-number                 = abap_true.
    ls_tile_infox-number_unit            = abap_true.
    ls_tile_infox-indicator              = abap_true.
    ls_tile_infox-valuecolor             = abap_true.
    ls_tile_infox-scale                  = abap_true.
    ls_tile_infox-details                = abap_true.
    ls_tile_infox-side_indicator_title1  = abap_true.
    ls_tile_infox-side_indicator_number1 = abap_true.
    ls_tile_infox-side_indicator_unit1   = abap_true.
    ls_tile_infox-side_indicator_title2  = abap_true.
    ls_tile_infox-side_indicator_number2 = abap_true.
    ls_tile_infox-side_indicator_unit2   = abap_true.

    server->api_tile_info(
      tile_info  = ls_tile_info
      tile_infox = ls_tile_infox
    ).
  endif.

endmethod.


  method numeric_db.

    me->db_read( ).

    me->server->api_tile_info(
      exporting
        title                  = gs_menu-tile_title
        info                   = gs_menu-tile_info
        icon                   = gs_menu-tile_icon
        footer                 = gs_menu-tile_footer
        number                 = gs_menu-tile_number
        number_unit            = gs_menu-tile_unit
        indicator              = gs_menu-tile_indicator
        valuecolor             = gs_menu-tile_valuecolor
        scale                  = gs_menu-tile_scale
        details                = gs_menu-tile_details
        side_indicator_title1  = gs_menu-tile_sidetitle1
        side_indicator_number1 = gs_menu-tile_sidenumber1
        side_indicator_unit1   = gs_menu-tile_sideunit1
        side_indicator_title2  = gs_menu-tile_sidetitle2
        side_indicator_number2 = gs_menu-tile_sidenumber2
        side_indicator_unit2   = gs_menu-tile_sideunit2
    ).

  endmethod.                    "numeric_db


method radial.

  data lv_menu type /neptune/menu.
  data ls_tile_info  type /neptune/api_tile_info.

  gs_menu = zcl_neptune_demo_appearance=>get_random_data( ).

  server->api_tile_info(
    exporting
      value1 = gs_menu-tile_value1
      value2 = gs_menu-tile_value2
      value3 = gs_menu-tile_value3
      color1 = gs_menu-tile_color1
  ).

endmethod.


  method randomize.
    menu = zcl_neptune_demo_appearance=>get_random_data( ).
  endmethod.                    "randomize
ENDCLASS.
