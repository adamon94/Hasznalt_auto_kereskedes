import { defineStore } from "pinia"


export const useController = defineStore('control', {
  state: () => ({ 
    modalState: false,
    logModal:false,
    isLogged:false,
    id: null,
    isFav:null,
    testDriveModal:false,
    accessLevel:null,
    setManageContent:"updateCar",
  }),
  actions:{
    logIn(){
        this.isLogged = true
        console.log("Bejelentkezve")
        
    },
    logOut(){
      this.isLogged = false
      localStorage.removeItem("isLogged")
      localStorage.removeItem("token")
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