import { defineStore } from "pinia"

export const useController = defineStore('control', {
  state: () => ({ 
    modalState: false,
    logModal:false,
    isLogged:false
  }),
  actions:{
    logIn(){
        this.isLogged = true
        console.log("Bejelentkezve")
    },

    showModal(){
      this.modalState = true
      
    },
    closeModal(){
      this.modalState = false
      
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
      if(this.modalState){
        return true
      }
    },

    logValue(){
       if(this.logModal){
        return true
      }
    
    },

    logged(){
      if(this.isLogged){
        return true
      }
    }
    


  }
  
})