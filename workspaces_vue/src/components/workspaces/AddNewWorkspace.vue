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
              <li v-bind:class="[tab == 7 ? typing : '' ]">7. Photos<i v-bind:class="[tab > 7 ? checked : '' ]"></i></li>
              <li v-bind:class="[tab == 8 ? typing : '' ]">8. Prices<i v-bind:class="[tab > 8 ? checked : '' ]"></i></li>
            </ul>
          </b-col>
          <b-col cols="9">
            <!-- Description -->
            <div class="description" v-if="tab==1">
              <h3>Tell us about your space</h3>
              <div class="form-content">
                <b-form>
                  <b-form-group id="group-name" label="Workspace's name" label-for="workspace-name">
                    <b-form-input id="workspace-name" type="text" placeholder="Enter name">
                    </b-form-input>
                  </b-form-group>
                  <b-form-group id="group-description" label="Description" label-for="workspace-description">
                    <b-form-textarea id="workspace-description" :rows="3" placeholder="Description">
                    </b-form-textarea>
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
                      <b-form-input id="workspace-email" type="email" placeholder="Enter email">
                      </b-form-input>
                    </b-form-group>
                    <b-form-group id="group-contact-phone" label="Phone" label-for="workspace-phone">
                      <b-form-input id="workspace-phone" type="text" placeholder="Enter phone number">
                      </b-form-input>
                    </b-form-group>
                    <b-form-group id="group-contact-website" label="Website URL" label-for="workspace-website">
                      <b-form-input id="workspace-website" type="text" placeholder="Enter website">
                      </b-form-input>
                    </b-form-group>
                  </b-form>
                </div>
              </div>
              <div class="social-contact">
                <h4>Social contact</h4>
                <div class="form-content">
                  <b-form>
                    <b-form-group id="group-contact-facebook" label="Facebook" label-for="workspace-facebook">
                      <b-form-input id="workspace-facebook" type="text" placeholder="Enter facebook">
                      </b-form-input>
                    </b-form-group>
                  </b-form>
                </div>
              </div>
            </div>
            <!-- /Contact -->
            <!-- Location -->
            <!-- /Location -->
            <!-- Amenities -->
            <div class="amenities" v-if="tab==4">
              <h3>Tell us about your amenities</h3>
              <div class="form-content">
                <b-form-group label="Amenities of our workspace">
                  <b-form-checkbox-group plain stacked v-model="amenities_selected" :options="options_amenities" />
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
                  <select v-model="private_number">
                    <option value="">---</option>
                    option
                    <option v-for="option in 10" v-bind:value="option" :key="option">
                      {{ option }}
                    </option>
                  </select>
                  <div v-for="room in private_number" :key="room">
                    <b-row>
                      <b-col>
                        <b-form-input type="text" placeholder="Enter name">
                        </b-form-input>
                      </b-col>
                      <b-col>
                        <b-form-input type="number" placeholder="Number of people">
                        </b-form-input>
                      </b-col>
                    </b-row>
                  </div>
                </div>
              </div>
              <div class="meeting-room">
                <h4>Meeting room</h4>
                <div class="form-content">
                  <select v-model="meeting_number">
                    <option value="">---</option>
                    <option v-for="option in 10" v-bind:value="option" :key="option">
                      {{ option }}
                    </option>
                  </select>
                  <div v-for="room in meeting_number" :key="room">
                    <b-row>
                      <b-col>
                        <b-form-input type="text" placeholder="Enter name">
                        </b-form-input>
                      </b-col>
                      <b-col>
                        <b-form-input type="number" placeholder="Number of people">
                        </b-form-input>
                      </b-col>
                    </b-row>
                  </div>
                </div>
              </div>
              <div class="common-room">
                <h4>Common area</h4>
                <div class="form-content">
                  <select v-model="common_number">
                    <option value="">---</option>
                    <option v-for="option in 10" v-bind:value="option" :key="option">
                      {{ option }}
                    </option>
                  </select>
                  <div v-for="room in common_number" :key="room">
                    <b-row>
                      <b-col>
                        <b-form-input type="text" placeholder="Enter name">
                        </b-form-input>
                      </b-col>
                      <b-col>
                        <b-form-input type="number" placeholder="Number of people">
                        </b-form-input>
                      </b-col>
                    </b-row>
                  </div>
                </div>
              </div>
              <div class="open-room">
               <h4>Open plan office</h4>
               <div class="form-content">
                 <select v-model="open_number">
                   <option value="">---</option>
                   <option v-for="option in 10" v-bind:value="option" :key="option">
                    {{ option }}
                  </option>
                </select>
                <div v-for="room in open_number" :key="room">
                  <b-row>
                    <b-col>
                      <b-form-input type="text" placeholder="Enter name">
                      </b-form-input>
                    </b-col>
                    <b-col>
                      <b-form-input type="number" placeholder="Number of people">
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
              <div v-for="day in week" :key="day">
                <p>{{day}}</p>
                <b-row>
                  <b-col>
                    <el-time-select :picker-options="{ start: '00:00', step: '00:15', end: '23:30'}"
                    placeholder="Open time">
                  </el-time-select>
                </b-col>
                <b-col>
                  <el-time-select :picker-options="{ start: '00:30', step: '00:15', end: '23:30'}"
                  placeholder="Close time">
                </el-time-select>
              </b-col>
            </b-row>
          </div>
        </div>
      </div>
      <!-- /Opening hours -->
      <!-- Photos -->
      <!-- /Photos -->
      <!-- Prices -->
      <div class="price" v-if="tab==8">
        <div class="form-content">
          <h3>Price</h3>
          <b-container fluid>
            <b-row class="my-1" v-for="type in types" :key="type">
              <b-col sm="3"><label :for="`type-${type}`">1 {{ type }}</label></b-col>
              <b-col sm="6"><b-form-input :id="`type-${type}`" type="number"></b-form-input></b-col>
              <b-col sm="3"><b-form-select v-model="unit_default" :options="unit" class="mb-3"></b-form-select></b-col>
            </b-row>
          </b-container>
        </div>
      </div>
      <!-- /rices -->
    </b-col>
  </b-row>
  <b-row>
   <b-col cols="2" offset="10">
     <div class="btn-control">
      <b-button type="button" variant="primary previous-btn" @click="decreaseTab" v-if="tab>1">Previous</b-button>
      <b-button type="button" variant="primary next-btn" @click="increaseTab" v-if="tab<8">Next</b-button>
    </div>
  </b-col>
</b-row>
</div>
</div>
</div>
</template>
<script>
  export default {
    data() {
      return {
        tab: 1,
        checked: 'fa fa-check',
        typing: 'typing',
        options_amenities: [
        { text: 'Free-wifi', value: 'wifi'},
        { text: 'Free coffee', value: 'coffee'},
        { text: 'Air Conditioning', value: 'air-conditioning'},
        { text: 'Kitchen', value: 'kitchen'},
        { text: 'Free water', value: 'water'},
        { text: 'Lounge Area', value: 'lounge-area'},
        ],
        amenities_selected: [],
        private_number: '',
        meeting_number: '',
        common_number: '',
        open_number: '',
        week: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        types: ['hour', 'day', 'week', 'month', 'year'],
        unit: [
        {value: 'vnd', text: 'VND'},
        {value: 'usd', text: 'USD'}
        ],
        unit_default: 'vnd'
      }
    },
    methods: {
      increaseTab: function() {
        this.tab += 1 
      },
      decreaseTab: function() {
        this.tab -=1
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

  li:hover {
    background-color: #28a745;
    color: white;
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