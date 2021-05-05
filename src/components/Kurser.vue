<template>
  <div>
      <div class="kurs" v-for="kurs in infos.content" :key="kurs.content.educationInfo.identifier">
        <h2>{{ shorter(kurs).title.string[0].content }} - {{ shorter(kurs).code }}</h2>
            {{ shorter(kurs).description.string[0].content }}

        <br><br>

        Länk: 
        <a :href="shorter(kurs).url.url[0].content" target="_blank">{{ shorter(kurs).url.url[0].content }}</a>
      </div>
  </div>
</template>

<script>
//import _ from 'lodash'

export default {
  name: 'Kurser',
  data () {
    return {
        infos: false,
    }
  },

  props: {
    subject: Object
  },

  computed: {

  },

  watch: {
      subject () {
          this.getInfos()
      }
  },
  
  methods: {
      shorter(kurs) {
        return kurs.content.educationInfo
      },

      getInfos () {
          fetch('https://susanavet2.skolverket.se/api/1.1/infos?page=0&size=2000&subjectIds=' + this.subject.id)
          .then((response) => response.json())
          .then((data) => {
              this.infos = data
          })
      }
  },

  mounted () {
      this.getInfos()
  }
}
</script>

<style scoped>
    .kurs h2 {
        font-size: 14px;
    }

    .kurs {
        font-size: 12px;
        padding: 20px 10px;
        margin: 0 0 10px 0;
        border: 1px solid #ccc;
    }
</style>
