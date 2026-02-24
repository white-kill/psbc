<template>
  <div id="app">
    <router-view/>
  </div>
</template>
<script>

import {mapMutations, mapState,} from 'vuex'

export default {
  data() {
    return {}
  },
  computed: {
    ...mapState(['token']),
  },
  mounted() {
    // 监听Flutter传来的数据
    window.addEventListener('flutter_setToken', this.handleFlutterData);
  },
  beforeUnmount() {
    window.removeEventListener('flutter_setToken', this.handleFlutterData);
  },
  methods: {
    ...mapMutations(['init_token', 'init_user_info']),
    handleFlutterData(event) {
      console.log(event.detail,'init_token')
      if (event.detail) {
        this.init_token({
          token: event.detail
        })
      }
    },

    sendMessageToFlutter(message) {
      if (window.FlutterBridge) {
        window.FlutterBridge.postMessage({
          action: 'showMessage',
          message: message
        });
      }
    }
  }

}
</script>
<style lang="scss">
#app {
  width: 100%;
  height: 100%;
}

</style>
