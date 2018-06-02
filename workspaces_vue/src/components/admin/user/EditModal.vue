<template>
  <div>
    <b-modal id="editModal" ref="editModal" hide-footer title="Edit user">
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="User name"
      label-for="user-name">
        <b-form-input id="user-name" v-model="username" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="First name"
      label-for="first-name">
        <b-form-input id="first-name" v-model="firstName" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Last name"
      label-for="last-name">
        <b-form-input id="last-name" v-model="lastName" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Birthday"
      label-for="birthday">
        <b-form-input type="date" id="birthday" v-model="birthday" size="sm"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Email"
      label-for="email">
        <b-form-input id="email" size="sm" v-model="email" ></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Phone"
      label-for="phone">
        <b-form-input id="phone" size="sm" v-model="phone"></b-form-input>
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Role"
      label-for="role">
        <b-form-select id="role" :options="roleList" v-model="role" class="mb-3" />
      </b-form-group>
      <b-form-group horizontal
      :label-cols="4"
      label-size="sm"
      label="Gender"
      label-for="gender">
        <b-form-radio-group id="radios" v-model="gender" :options="genderList">
      </b-form-radio-group>
      </b-form-group>
      <div class="btn-control">
        <b-btn variant="primary" @click="editUser">Save</b-btn>
        <b-btn variant="danger" @click="hideModal">Cancel</b-btn>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    props: ['user'],
    data() {
      return {
        username: '',
        firstName: '',
        lastName: '',
        birthday: '',
        email: '',
        phone: '',
        role: null,
        gender: '',
        roleList: [
          {value: 'user', text: 'User'},
          {value: 'partner', text: 'Partner'},
          {value: 'admin', text: 'Admin'}
        ],
        genderList: [
          {value: 'male', text: 'male'},
          {value: 'female', text: 'female'}
        ],
      }
    },
    computed: {
      ...mapState({
        editStatus:state => state.account.editStatus
      })
    },
    methods: {
      ...mapActions({
        'editAccount': 'account/editAccount',
        'fetch': 'account/getAllAccount'
      }),
      editUser() {
        this.editAccount({'user': {
          id: this.user.id,
          username: this.username,
          first_name: this.firstName,
          last_name: this.lastName,
          birthday: this.birthday,
          email: this.email,
          phone: this.phone,
          role: this.role,
          gender: this.gender
        }
      })
        this.hideModal()
      },
      hideModal() {
        this.$refs.editModal.hide()
      }
    },
    watch: {
      user() {
        this.username = this.user.username
        this.firstName = this.user.first_name
        this.lastName = this.user.last_name
        this.birthday = this.user.birthday
        this.email = this.user.email
        this.phone = this.user.phone
        this.role = this.user.role
        this.gender = this.user.gender
      },
      editStatus() {
        this.fetch()
      }
    }
  }
</script>
<style>
  #newModal {
    padding: 20px;
  }

  .modal-body {
    padding: 2rem;
  }

  .btn-control {
    float: right
  }
</style>