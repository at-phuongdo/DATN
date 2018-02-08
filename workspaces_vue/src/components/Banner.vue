<template>
  <div class="banner">
    <div class="search">
     <b-row>
       <b-col md="4" offset-md="4">
         <h1 class="search-title"><span class="decorate-span">Let's</span> find a workspace</h1>
       </b-col>
     </b-row>
     <b-row>
       <b-col md="4" offset-md="4" class="search-content">
        <b-form-input  type="text" placeholder="Please enter country or city you want to find..." class="search-input"></b-form-input>
        <b-dropdown id="ddown-lg" size="lg" text="All spaces" variant="dropdown-button">
          <b-dropdown-item-button>All spaces</b-dropdown-item-button>
          <b-dropdown-item-button>Meeting spaces</b-dropdown-item-button>
          <b-dropdown-item-button>Workspace</b-dropdown-item-button>
        </b-dropdown>
        <b-button variant="success search-button">Search</b-button>
      </b-col>
    </b-row>
  </div>
</div>
</template>
<script>
</script>
<style>
  @import url('https://fonts.googleapis.com/css?family=Pacifico');
  .banner {
    height: 700px;
    background-image: url('../assets/banner.jpg');
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
  }
  .search {
    padding: 350px 0;
  }
  .search-title {
    color: white;
    text-shadow: 6px 6px 4px #000000;
    font-weight: bold;
  }
  .decorate-span {
    font-family: 'Pacifico', cursive;
    color: #28a745;
  }
  .search-content {
    display: inherit;
  }

  .btn-dropdown-button,
  .search-input {
    border-radius: 0;
  }

  .search-button {
    margin-left: 10px;
  }
</style>