<template>
  <div>
    <div id="floating-panel">
      <input id="address" type="textbox" value="Sydney, NSW">
      <input id="submit" type="button" value="Geocode" @click="geocodeAddress">
    </div>
    <div class="google-map" :id="mapName"></div>
    <div class="address">
      <p>Confirm and complete any missing details in the location information below:</p>
      <b-row>
        <b-col>
          <b-form-group label="Street" label-for="street">
            <b-form-input id="street" v-model="street"></b-form-input>
          </b-form-group>
          <b-form-group label="District*" label-for="district">
            <b-form-input id="district" v-model="district"></b-form-input>
          </b-form-group>
          <b-form-group label="Country*" label-for="country">
            <b-form-input id="country" v-model="country"></b-form-input>
          </b-form-group>
        </b-col>
        <b-col>
         <b-form-group label="Town*" label-for="town">
          <b-form-input id="town" v-model="town"></b-form-input>
        </b-form-group>
        <b-form-group label="City*" label-for="city">
          <b-form-input id="city" v-model="city"></b-form-input>
        </b-form-group>
      </b-col>
    </b-row>
  </div>
</div>
</template>
<script>
  export default {
    name: 'google-map',
    props: ['name'],
    data: function () {
      return {
        mapName: this.name + "-map",
        markerCoordinates: [{
          latitude: 16.056115,
          longitude: 108.190248
        }],
        street : '',
        town : '',
        district : '',
        city : '',
        country : ''
      }
    },

    mounted: function () {
      const element = document.getElementById(this.mapName)
      const options = {
        zoom: 6,
        center: new google.maps.LatLng(16.056115,108.190248)
      }
      const map = new google.maps.Map(element, options)
      this.markerCoordinates.forEach((coord) => {
        const position = new google.maps.LatLng(coord.latitude, coord.longitude)
        const marker = new google.maps.Marker({ 
          position,
          draggable: true,
          map : map
        });
        google.maps.event.addListener(marker, 'dragend', function(ev){
        alert(marker.getPosition())
      });
      });
    },

    methods: {
      geocodeAddress: function(resultsMap) {
        var geocoder = new google.maps.Geocoder()
        const element = document.getElementById(this.mapName)
        const options = {
          zoom: 6,
          center: new google.maps.LatLng(16.056115,108.190248)
        }
        const map = new google.maps.Map(element, options);
        var address = document.getElementById('address').value;
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status)
          }
        });
      }
    }
  }
</script>
<style scoped>
  .google-map {
    width: 800px;
    height: 500px;
    margin: 0 auto;
    background: gray;
  }
  .address {
    background-color: #F9F9F9;
    padding: 20px;
  }
</style>