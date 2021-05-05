<template>
  <div v-if="yrkesgrupper">
    <input name="onlySun" type="checkbox" v-model="onlySun"> <label for="onlySun">Bara med SUN-koder</label>

    <br>{{ sortedYrkesgrupper.length }} / {{ yrkesgrupper.length }} yrkesgrupper<br>

    <ul class="list-group">
        <li class="list-group-item yrkesgrupp" v-for="yrkesgrupp in sortedYrkesgrupper" :key="yrkesgrupp.id" @click="$emit('selected', yrkesgrupp)">
          <span class="negative" :class="{ positive: yrkesgrupp.sunkoder.length }"></span>
          {{ yrkesgrupp.name }}
        </li>
    </ul>
  </div>
</template>

<script>
import _ from 'lodash'

export default {
  name: 'Yrkesgrupper',
  data () {
    return {
        onlySun: true,
        yrkesgrupper: false
    }
  },

  computed: {
      sortedYrkesgrupper () {
        let y = _.sortBy(this.yrkesgrupper, ['name'])

        if (this.onlySun) {
          return _.filter(y, (x) => x.sunkoder.length)
        }

        return y
      }
  },
  
  methods: {
      getYrkesgrupper () {

          let cached = localStorage.getItem('yrkesgrupper')

          if (cached) {
            this.yrkesgrupper = JSON.parse(cached)
            return
          }

          fetch('https://app-yrkesinfo.test.services.jtech.se/api/v1/yrkesgrupper')
          .then((response) => response.json())
          .then((data) => {
              localStorage.setItem('yrkesgrupper', JSON.stringify(data))
              this.yrkesgrupper = data
          })
      }
  },

  mounted () {
      this.getYrkesgrupper()
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .negative {
    display: inline-block;
    width: 10px;
    height: 10px;
    background: red;
  }

  .positive {
    background: green;
  }

  .yrkesgrupp {
    cursor: pointer;
  }
</style>
