<template>
  <div class="form-workspace">
    <h2>{{workspace.name}}</h2>
    <!-- Description -->
    <b-btn v-b-toggle.description class="colapse-btn">Description</b-btn>
    <b-collapse visible id="description">
      <div class="form-content">
        <b-form>
          <b-form-group id="group-name" label="Workspace's name" label-for="workspace-name">
            <b-form-input id="workspace-name" type="text" v-model="workspace.name" placeholder="Enter name">
            </b-form-input>
          </b-form-group>
          <b-form-group id="group-description" label="Description" label-for="workspace-description">
            <ckeditor 
            v-model="workspace.description" 
            :config="config">
          </ckeditor>
        </b-form-group>
      </b-form>
    </div>
  </b-collapse>
  <!-- /Description -->
  <!-- Contact -->
  <b-btn v-b-toggle.contact class="colapse-btn">Contact</b-btn>
  <b-collapse visible id="contact">
    <div class="official-contact">
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
          </b-form-group>
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
  </b-collapse>
  <!-- /Contact -->
  <!-- Location -->
  <b-btn v-b-toggle.location class="colapse-btn">Location</b-btn>
  <b-collapse visible id="location">
    <google-map
    name="location" @getAddress="getAddress" :addressWorkspace="workspace"
    ></google-map>
  </b-collapse>
  <!-- /Location -->
  <!-- Amenities -->
  <b-btn v-b-toggle.amenities class="colapse-btn">Amenities</b-btn>
  <b-collapse visible id="amenities">
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
  </b-collapse>
  <!-- /Amenities -->
  <b-row class="submit-btn">
    <b-button type="button" variant="primary submit-btn" @click="submit">Save</b-button>
    <b-button type="button" variant=" submit-btn" @click="cancel">Cancel</b-button>
  </b-row>
</div>
</template>
<script>
  import MapComponent from '../../workspaces/Map.vue'
  import Ckeditor from 'vue-ckeditor2'
  import { mapActions, mapState } from 'vuex'
  export default {
    components: {
      'google-map' : MapComponent,
      'ckeditor' : Ckeditor
    },
    data() {
      return {
        config: {
          toolbar: [
          [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ]
          ],
          height: 300
        },
        amenities: [],
        amenities_selected: [],
        workspace: {}
      }
    },
    created() {
      this.getConvenient()
      this.getDetail(this.$route.params.id)
    },
    computed: {
      ...mapState({
       convenients:state => state.convenient.listConvenient,
       workspaceInfo:state => state.adminWorkspace.workspaceInfo
     })
    },
    methods: {
      ...mapActions({
        getConvenient: 'convenient/getAllConvenient',
        getDetail: 'adminWorkspace/getDetail'
      }),
      getAddress: function(address) {
        this.workspace.country = address.country
        this.workspace.city = address.city
        this.workspace.district = address.district
        this.workspace.town = address.town
        this.workspace.street = address.street
        this.workspace.lat = address.lat
        this.workspace.lng = address.lng
      },
      submit() {

      },
      cancel() {
        this.$router.push('/admin-workspace')
      }
    },
    watch: {
      convenients() {
        this.amenities = this.convenients
      },
      workspaceInfo() {
        this.workspace = this.workspaceInfo
        this.amenities_selected = this.workspaceInfo.convenient.map((item) => {
          return item.id
        })
      }
    }
  }

</script>
<style scoped>
  .colapse-btn {
    width: 100%;
    background-color: #40838c;
    margin: 5px;
  }

  .collapse {
    padding: 20px;
  }

  .form-workspace {
    width: 80%;
    float: right;
    padding: 20px 40px;
    margin: 30px;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
  }

  .submit-btn {
    float: right;
  }

</style>