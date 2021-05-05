<template>
  <div v-if="yrkesgrupp">
    <h2>{{ yrkesgrupp.name }}</h2>
    <div v-if="yrkesgrupp.sunkoder">
      {{ yrkesgrupp.sunkoder.length }} st sunkoder varav {{ matchedSubjects.length }} st fanns i Susanavet

      <ul>
        <li v-for="subject in matchedSubjects" :key="subject.id">
          {{ subject.name }}
          <button class="btn btn-link" @click="showKurserFor(subject)">Visa kurser</button>
        </li>
      </ul>
    </div>
    <div v-if="showKurser">
      <Kurser :subject=showKurser></Kurser>
    </div>
  </div>
</template>

<script>
import _ from 'lodash'
import Kurser from './Kurser'

export default {
  name: 'Susanavet',
  
  components: {
    Kurser
  },

  data () {
    return {
        subjects: false,
        showKurser: false,
        matchedSubjects: [],
    }
  },

  props: {
    yrkesgrupp: Object
  },

  computed: {

  },

  watch: {
      yrkesgrupp (yrkesgrupp) {
        this.matchedSubjects = []
        this.showKurser = false
        for (let sunkod of yrkesgrupp.sunkoder) {
          let subject = this.findSubjectFromSunkod(sunkod)
          if (subject) {
            this.matchedSubjects.push(subject)
          }
        }
      }
  },
  
  methods: {
      showKurserFor (subject) {
        this.showKurser = subject
      },

      findSubjectFromSunkod (sunkod) {
          return _.find(this.subjects.content, { code: sunkod })
      },

      getInfos (subject) { 

        if (subject.links[0]) {
          let href = subject.links[0].href
          console.log(href)
        }

      },

      getSubjects () {

          let cached = localStorage.getItem('subjects')

          if (cached) {
            this.subjects = JSON.parse(cached)
            return
          }

          fetch('https://susanavet2.skolverket.se/api/1.1/subjects?page=0&size=2000')
          .then((response) => response.json())
          .then((data) => {
              localStorage.setItem('subjects', JSON.stringify(data))
              this.subjects = data
          })
      }
  },

  mounted () {
      this.getSubjects()
  }
}
</script>

<style scoped>
  
</style>
