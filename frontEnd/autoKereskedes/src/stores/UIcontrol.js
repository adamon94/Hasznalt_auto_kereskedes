import { defineStore } from "pinia"

export const useController = defineStore('control', {
  state: () => ({ 
    modalState: false,
    logModal:false, 
  }),
  actions:{
    showModal(){
      this.modalState = true
      console.log(this.modalState)
    },
    closeModal(){
      this.modalState = false
      console.log(this.modalState)
    },
    
    showLog(){
      this.logModal = true
      
    },
    closeLog(){
      this.logModal = false
    },

   
  
  },
  
  getters:{

    modalValue(){
      if(this.modalState === true){
        return true
      }
    },

    logValue(){
       if(this.logModal === true){
        return true
      }
    }
    


  }
  
})