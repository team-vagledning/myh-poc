<template>
  <div class="row">
    <div class="col-md-3 yrkesgrupper">
      <Yrkesgrupper @selected="selectYrkesgrupp"></Yrkesgrupper>
    </div>
    <div class="col-md-7 susanavet">
      <Susanavet :yrkesgrupp="selectedYrkesgrupp"></Susanavet>
    </div>
  </div>
</template>

<script>
import Yrkesgrupper from './Yrkesgrupper'
import Susanavet from './Susanavet'

export default {
  name: 'Main',
  components: {
    Yrkesgrupper,
    Susanavet
  },
  data () {
    return {
        selectedYrkesgrupp: {}
    }
  },
  methods: {
    selectYrkesgrupp (yrkesgrupp) {
      this.selectedYrkesgrupp = yrkesgrupp
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .yrkesgrupper {
    height: 90vh;
    overflow: auto;
    padding: 0 10px;
  }
</style>
