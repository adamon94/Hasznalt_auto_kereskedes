import { defineStore } from "pinia"

export const useController = defineStore('control', {
  state: () => ({ modalState: false, name: 'mod' }),
  actions:{
    showModal(){
      this.modalState = true
      console.log(this.modalState)
    },
    closeModal(){
      this.modalState = false
      console.log(this.modalState)
    },
    
  
  }, getters:{

    modalValue(){
      if(this.modalState === true){
        return true
      }
    }

  }
  
})