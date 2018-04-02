<template>
  <div>
    <div class="address">
      <p>Confirm and complete any missing details in the location information below:</p>
      <b-row>
        <b-col>
          <b-form-group label="Country*" label-for="country">
            <b-form-input id="country" v-model="address.country"></b-form-input>
          </b-form-group>
          <b-form-group label="District*" label-for="district">
            <b-form-input id="district" v-model="address.district"></b-form-input>
          </b-form-group>
          <b-form-group label="Street" label-for="street">
            <b-form-input id="street" v-model="address.street"></b-form-input>
          </b-form-group>
        </b-col>
        <b-col>
         <b-form-group label="City*" label-for="city">
          <b-form-input id="city" v-model="address.city"></b-form-input>
        </b-form-group>
        <b-form-group label="Town*" label-for="town">
         <b-form-input id="town" v-model="address.town"></b-form-input>
       </b-form-group>
     </b-col>
   </b-row>
   <p class="notice">If you sure about your information, please generate to map to save location.</p>
   <b-btn variant="danger" @click="geocodeAddress">Generate to map?</b-btn>
 </div>
 <div class="google-map" :id="mapName"></div>
</div>
</template>
<script>
  export default {
    name: 'google-map',
    props: ['name', 'addressWorkspace'],
    data: function () {
      return {
        mapName: this.name + "-map",
        markerCoordinates: [{
          latitude: 16.056115,
          longitude: 108.190248
        }],
        address: {
          street : this.addressWorkspace.street,
          town : this.addressWorkspace.town,
          district : this.addressWorkspace.district,
          city : this.addressWorkspace.city,
          country : this.addressWorkspace.country,
          stringAddress: '',
          lat: this.addressWorkspace.lat,
          lng: this.addressWorkspace.lng
        }
      }
    },

    mounted: function () {
      const element = document.getElementById(this.mapName)
      const options = {
        zoom: 6,
        // center: new google.maps.LatLng(16.056115,108.190248)
        center: new google.maps.LatLng(this.address.lat, this.address.lng)
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
        var address = this.stringAddress();
        var self = this
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
            var location = results[0].geometry.location
            map.setCenter(location)
            self.parseLatLng(location)
            var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location
            });
          } else {
            alert('Geocode was not successful for the following reason: ' + status)
          }
          google.maps.event.addListener(marker, 'dragend', function(ev){
            alert(marker.getPosition())
          });
        });
      },
      stringAddress: function() {
        this.address.stringAddress =  this.address.street + ' ' + this.address.town + ' ' + this.address.district + ' ' + this.address.city + ' ' + this.address.country
        return this.address.stringAddress
      },
      parseLatLng: function(location) {
        this.address.lat = location.lat().toString()
        this.address.lng = location.lng().toString()
        this.$emit('getAddress', this.address)
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
  .notice {
    color: red;
  }
</style>