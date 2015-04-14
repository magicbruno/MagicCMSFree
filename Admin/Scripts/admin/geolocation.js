$(function () {
    var lastaddress = "";
    var $map_canvas = $('#map-dialog .map-canvas');
    var $address_field = $('#geolocAddress');
    var $latLang_field = $address_field.siblings('input[type="hidden"]');
    $map_canvas
        .height($(window).height() * 0.6)
        .gmap3({
            map: {
                options: {
                    center: 'Roma Italy',
                    zoom: 17
                }
            },
            marker: {
                latLng: new google.maps.LatLng(0, 0),
                options: {
                    draggable: true
                },
                events: {
                    dragend: function (marker) {
                        $address_field.parent().spin();
                        $latLang_field.val(marker.getPosition().toString());
                        $(this).gmap3({
                            getaddress: {
                                latLng: marker.getPosition(),
                                callback: function (results) {
                                    $address_field.val(results ? results[0].formatted_address || results[1].formatted_address : "nessun indirizzo");
                                    $address_field.parent().spin(false);
                                }
                            }
                        });
                    }
                }
            }
        });

    $('#map-dialog')
        .on('shown.bs.modal', function (e) {
            $map_canvas
                .height($(window).height() * 0.6);
            var map = $map_canvas.gmap3('get');
            google.maps.event.trigger(map, "resize");

            var $this = $(this);
            var $btn = $(e.relatedTarget);
            var selector = $btn.attr('data-source');
            $this.attr('data-souce', selector);
            var address = $(selector).val();
            var $title = $this.find('.modal-title');
            address = address || "Roma Italy";
            $address_field.val(address);
            $('[data-action="geo-search"]').trigger('click');
        })
        .on('hide.bs.modal', function () {
            var selector = $(this).attr('data-souce');
            var $address_field = $('#geolocAddress');
            var $latLang_field = $address_field.siblings('input[type="hidden"]');
            $(selector).val($latLang_field.val()).change();

        });

    $('[data-action="geo-search"]').on('click', function (e) {
        e.preventDefault();
        var $this = $(this);
        var $map_canvas = $('#map-canvas');
        var selector = $this.attr('data-source');
        var $address_field = $(selector);
        var $latLang_field = $address_field.siblings('input[type="hidden"]');
        var address = $address_field.val();
        $address_field.parent().spin();
        $map_canvas.gmap3({
            getlatlng: {
                address: address,
                callback: function (results) {
                    if (!results) {
                        $address_field.val("Impossibile calcolare la locazione. Prova a specificare meglio l'indirizzo");
                        return;
                    }
                    $address_field.val(address);
                    var latlng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
                    $latLang_field.val(latlng.toString());
                    var theMap = $map_canvas.gmap3('get');
                    var theMarker = $map_canvas.gmap3({
                        get: {
                            name: 'marker',
                            first: true,
                            all: false
                        }
                    });
                    if (theMap)
                        theMap.setCenter(latlng);
                    if (theMarker)
                        theMarker.setPosition(latlng);
                    google.maps.event.trigger(theMarker, 'dragend');
                    $address_field.parent().spin(false);

                }
            }
        })
    })

})
