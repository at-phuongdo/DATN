<template>
  <div>
    <div class="container">
      <div class="form-workspace">
        <b-row>
          <b-col cols="3">
            <ul>
              <li v-bind:class="[tab == 1 ? typing : '' ]">1. Description <i v-bind:class="[tab > 1 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 2 ? typing : '' ]">2. Contact<i v-bind:class="[tab > 2 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 3 ? typing : '' ]">3. Location<i v-bind:class="[tab > 3 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 4 ? typing : '' ]">4. Amenities<i v-bind:class="[tab > 4 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 5 ? typing : '' ]">5. Room<i v-bind:class="[tab > 5 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 6 ? typing : '' ]">6. Opening hours<i v-bind:class="[tab > 6 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 7 ? typing : '' ]">7. Prices<i v-bind:class="[tab > 7 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 8 ? typing : '' ]">8. Photos<i v-bind:class="[tab > 8 ? checked : '' ]"></i></li>
            </ul>
          </b-col>
          <b-col cols="9">
            <!-- Description -->
            <div class="description" v-if="tab==1">
              <h3>Tell us about your space</h3>
              <div class="form-content">
                <b-form>
                  <b-form-group id="group-name" label="Workspace's name" label-for="workspace-name">
                    <b-form-input id="workspace-name" type="text" v-model="workspace.name" placeholder="Enter name">
                    </b-form-input>
                  </b-form-group>
                  <b-form-group id="group-description" label="Description" label-for="workspace-description">
                    <ckeditor 
                    v-model="workspace.description" 
                    :config="config" 
                    @blur="onBlur($event)" 
                    @focus="onFocus($event)">
                  </ckeditor>
                </b-form-group>
              </b-form>
            </div>
          </div>
          <!-- /Description -->
          <!-- Contact -->
          <div class="contact" v-if="tab==2">
            <h3>How can I contact you? </h3>
            <div class="official-contact">
              <h4>Official contact details</h4>
              <div class="form-content">
                <b-form>
                  <b-form-group id="group-contact-email" label="Email" label-for="workspace-email">
                    <b-form-input id="workspace-email" type="email" v-model="workspace.email" placeholder="Enter email">
                    </b-form-input>
                  </b-form-group>
                  <b-form-group id="group-contact-phone" label="Phone" label-for="workspace-phone">
                    <b-form-input id="workspace-phone" type="text" v-model="workspace.phone" placeholder="Enter phone number">
                    </b-form-input>
                  </b-form-group>
                  <b-form-group id="group-contact-website" label="Website URL" label-for="workspace-website">
                    <b-form-input id="workspace-website" type="text" v-model="workspace.website" placeholder="Enter website">
                    </b-form-input>
                  </b-form-group>workspace
                </b-form>
              </div>
            </div>
            <div class="social-contact">
              <h4>Social contact</h4>
              <div class="form-content">
                <b-form>
                  <b-form-group id="group-contact-facebook" label="Facebook" label-for="workspace-facebook">
                    <b-form-input id="workspace-facebook" type="text" v-model="workspace.facebook" placeholder="Enter facebook">
                    </b-form-input>
                  </b-form-group>
                </b-form>
              </div>
            </div>
          </div>
          <!-- /Contact -->
          <!-- Location -->
          <div class="location" v-if="tab==3">
            <google-map
            name="location" @getAddress="getAddress" :addressWorkspace="workspace"
            ></google-map>
          </div>
          <!-- /Location -->
          <!-- Amenities -->
          <div class="amenities" v-if="tab==4">
            <h3>Tell us about your amenities</h3>
            <div class="form-content">
              <b-form-group label="Amenities of our workspace">
                <span v-for="amenity in amenities" :key="amenity.id">
                  <input
                  type='checkbox'
                  :value="amenity.id"
                  v-model='amenities_selected'> {{amenity.name}}
                  <br>
                </span>
              </b-form-group>
            </div>
          </div>
          <!-- /Amenities -->
          <!-- Room -->
          <div class="room" v-if="tab==5">
            <h3>Got any office types?</h3>
            <div class="private-room">
              <h4>Private office</h4>
              <div class="form-content">
                <select v-model="privateNumber">
                  <option value="">---</option>
                  option
                  <option v-for="option in 10" v-bind:value="option" :key="option">
                    {{ option }}
                  </option>
                </select>
                <div v-for="room in privateNumber" :key="room">
                  <b-row>
                    <b-col>
                      <b-form-input type="text" v-model="nameRoom.privateRoom[room-1]" placeholder="Enter name">
                      </b-form-input>
                    </b-col>
                    <b-col>
                      <b-form-input type="number" v-model="numberOfPeoplePerRoom.privateRoom[room-1]" placeholder="Number of people">
                      </b-form-input>
                    </b-col>
                  </b-row>
                </div>
              </div>
            </div>
            <div class="meeting-room">
              <h4>Meeting room</h4>
              <div class="form-content">
                <select v-model="meetingNumber">
                  <option value="">---</option>
                  <option v-for="option in 10" v-bind:value="option" :key="option">
                    {{ option }}
                  </option>
                </select>
                <div v-for="room in meetingNumber" :key="room">
                  <b-row>
                    <b-col>
                      <b-form-input type="text" v-model="nameRoom.meetingRoom[room-1]" placeholder="Enter name">
                      </b-form-input>
                    </b-col>
                    <b-col>
                      <b-form-input type="number" v-model="numberOfPeoplePerRoom.meetingRoom[room-1]" placeholder="Number of people">
                      </b-form-input>
                    </b-col>
                  </b-row>
                </div>
              </div>
            </div>
            <div class="common-room">
              <h4>Common area</h4>
              <div class="form-content">
                <select v-model="commonNumber">
                  <option value="">---</option>
                  <option v-for="option in 10" v-bind:value="option" :key="option">
                    {{ option }}
                  </option>
                </select>
                <div v-for="room in commonNumber" :key="room">
                  <b-row>
                    <b-col>
                      <b-form-input type="text" v-model="nameRoom.commonRoom[room-1]" placeholder="Enter name">
                      </b-form-input>
                    </b-col>
                    <b-col>
                      <b-form-input type="number" v-model="numberOfPeoplePerRoom.commonRoom[room-1]" placeholder="Number of people">
                      </b-form-input>
                    </b-col>
                  </b-row>
                </div>
              </div>
            </div>
            <div class="open-room">
             <h4>Open plan office</h4>
             <div class="form-content">
               <select v-model="openNumber">
                 <option value="">---</option>
                 <option v-for="option in 10" v-bind:value="option" :key="option">
                  {{ option }}
                </option>
              </select>
              <div v-for="room in openNumber" :key="room">
                <b-row>
                  <b-col>
                    <b-form-input type="text" v-model="nameRoom.openRoom[room-1]" placeholder="Enter name">
                    </b-form-input>
                  </b-col>
                  <b-col>
                    <b-form-input type="number" v-model="numberOfPeoplePerRoom.openRoom[room-1]" placeholder="Number of people">
                    </b-form-input>
                  </b-col>
                </b-row>
              </div>
            </div>
          </div>
        </div>
        <!-- /Room -->
        <!-- Opening hours -->
        <div class="opening-hours" v-if="tab==6">
          <h3>When you open your workspace?</h3>
          <div class="form-content">
            <div v-for="day in openingHours" :key="day.name">
              <p>{{day.text}}</p>
              <b-row>
                <b-col>
                  <el-time-select v-model="day.open" :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}"
                  placeholder="Open time">
                </el-time-select>
              </b-col>
              <b-col>
                <el-time-select v-model="day.close" :picker-options="{ start: '00:30', step: '00:15', end: '23:30'}"
                placeholder="Close time">
              </el-time-select>
            </b-col>
          </b-row>
        </div>
      </div>
    </div>
    <!-- /Opening hours -->
    <!-- Prices -->
    <div class="price" v-if="tab==7">
      <div class="form-content">
        <h3>Price</h3>
        <b-container fluid>
          <b-row class="my-1" v-for="type in priceTypes" :key="type.name">
            <b-col sm="3"><label :for="`type-${type.name}`">1 {{ type.name }}</label></b-col>
            <b-col sm="6"><b-form-input :id="`type-${type.name}`" type="number" v-model="type.price" :value="type.price"></b-form-input></b-col>
            <b-col sm="3"><b-form-select v-model="unit_default" :options="unit" class="mb-3"></b-form-select></b-col>
          </b-row>
        </b-container>
      </div>
    </div>
    <!-- /prices -->
    <!-- Photos -->
    <workspace-photos v-if="tab==8" v-on:getPhotos="getPhotos"></workspace-photos>
    <!-- /Photos -->
  </b-col>
</b-row>
<b-row>
 <b-col cols="2" offset="10">
   <div class="btn-control">
    <b-button type="button" variant="primary previous-btn" @click="decreaseTab" v-if="tab>1">Previous</b-button>
    <b-button type="button" variant="primary next-btn" @click="clickNextBtn" v-if="tab<8">Next</b-button>
    <b-button type="button" variant="primary next-btn" @click="submit" v-if="tab==8">OK</b-button>
  </div>
</b-col>
</b-row>
</div>
</div>
</div>
</template>
<script>
  import MapComponent from './Map.vue'
  import Photos from './Photos.vue'
  import Ckeditor from 'vue-ckeditor2'
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
    components: {
      'google-map' : MapComponent,
      'workspace-photos' : Photos,
      'ckeditor' : Ckeditor
    },
    data() {
      return {
        tab: 1,
        config: {
          toolbar: [
          [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ]
          ],
          height: 300
        },
        checked: 'fa fa-check',
        typing: 'typing',
        amenities: [],
        amenities_selected: [],
        privateNumber: '',
        meetingNumber: '',
        commonNumber: '',
        openNumber: '',
        nameRoom: {
          privateRoom: [],
          meetingRoom: [],
          commonRoom: [],
          openRoom: []
        },
        numberOfPeoplePerRoom: {
          privateRoom: [],
          meetingRoom: [],
          commonRoom: [],
          openRoom: []
        },
        priceTypes: [
        { name : 'hour', price: 0 },
        { name : 'day', price: 0 },
        { name : 'week', price: 0 },
        { name : 'month', price: 0 },
        { name : 'year', price: 0 }
        ],
        unit: [
        {text: 'VND', value: 'vnd'},
        {text: 'USD', value: 'usd'}
        ],
        unit_default: 'vnd',
        openingHours: [
        { day: 'open_mon', open: '', close: '', text: 'Monday'},
        { day: 'open_tue', open: '', close: '', text: 'Tuesday'},
        { day: 'open_wed', open: '', close: '', text: 'Wednesday'},
        { day: 'open_thurs', open: '', close: '', text: 'Thursday'},
        { day: 'open_fri', open: '', close: '', text: 'Friday'},
        { day: 'open_sat', open: '', close: '', text: 'Saturday'},
        { day: 'open_sun', open: '', close: '', text: 'Sunday'},
        ],
        workspace: {
          name: '',
          description: '',
          avatar: '',
          email: '',
          phone: '',
          website: '',
          facebook: '',
          street: '',
          town: '',
          district: '',
          city: '',
          country: '',
          lat: '',
          lng: '',
          open_mon: '',
          open_tue: '',
          open_wed: '',
          open_thurs: '',
          open_fri: '',
          open_sat: '',
          open_sun: '',
          price_hour: '',
          price_day: '',
          price_week: '',
          price_month: '',
          price_year: '',
          unit: ''
        },
        workspacePhotos: []
      }
    },
    created() {
      this.getConvenient()
    },
    watch: {
      convenients: function() {
        this.amenities = this.convenients
      }
    },
    computed: {
      ...mapState({
        convenients:state => state.convenient.listConvenient
      })
    },
    methods: {
      ...mapActions({
        addNewSpace: 'workspace/addNew',
        getConvenient: 'convenient/getAllConvenient'
      }),

      increaseTab: function() {
        this.tab += 1 
      },
      decreaseTab: function() {
        this.tab -=1
      },
      onBlur (editor) {
        console.log(editor)
      },
      onFocus (editor) {
        console.log(editor)
      },
      getAddress: function(address) {
        this.workspace.country = address.country
        this.workspace.city = address.city
        this.workspace.district = address.district
        this.workspace.town = address.town
        this.workspace.street = address.street
        this.workspace.lat = address.lat
        this.workspace.lng = address.lng
      },
      openingTime: function() {
        this.workspace.open_mon = this.openingHours[0].open + '-' + this.openingHours[0].close
        this.workspace.open_tue = this.openingHours[1].open + '-' + this.openingHours[1].close
        this.workspace.open_wed = this.openingHours[2].open + '-' + this.openingHours[2].close
        this.workspace.open_thurs = this.openingHours[3].open + '-' + this.openingHours[3].close
        this.workspace.open_fri = this.openingHours[4].open + '-' + this.openingHours[4].close
        this.workspace.open_sat = this.openingHours[5].open + '-' + this.openingHours[5].close
        this.workspace.open_sun = this.openingHours[6].open + '-' + this.openingHours[6].close
      },
      getPrice: function() {
        this.workspace.price_hour = this.priceTypes[0].price
        this.workspace.price_day = this.priceTypes[1].price
        this.workspace.price_week = this.priceTypes[2].price
        this.workspace.price_month = this.priceTypes[3].price
        this.workspace.price_year = this.priceTypes[4].price
      },
      getPhotos: function(photos) {
        this.workspace.avatar = photos[0]
        this.workspacePhotos = photos.slice(1)
      },

      clickNextBtn: function() {
        this.increaseTab()
        if (this.tab == 7) {
          this.openingTime()
        } else if (this.tab == 8) {
          this.getPrice()
        }
      },
      submit: function() {
        this.addNewSpace({
          workspace: this.workspace,
          photo: this.workspacePhotos,
          amenities: this.amenities_selected,
          nameRoom: this.nameRoom,
          numberPeople: this.numberOfPeoplePerRoom
        })
      }
    }
  }
</script>
<style scoped>
  .container {
    padding: 100px 0;
  }

  .form-workspace {
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    padding: 20px;
  }

  .form-content {
    background-color: #F9F9F9;
    padding: 10px;
  }

  li {
    list-style-type: none;
    border: 1px solid black;
    border-radius: 5px;
    padding: 10px;
    margin: 10px 0;
    background-color: #F9F9F9;
  }

  li i {
    float: right;
  }

  .btn-control {
    float: right;
  }

  .typing {
    background-color: #28a745;
    color: white;
  }

  select {
    width: 50%;
  }
</style>
