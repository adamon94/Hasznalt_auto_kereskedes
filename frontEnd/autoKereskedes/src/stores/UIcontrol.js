import { defineStore } from "pinia"
import { ro } from "vuetify/locale"

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
    logOut(){
      this.isLogged = false
      localStorage.removeItem("isLogged")
      console.log("Kijelentkezve")
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