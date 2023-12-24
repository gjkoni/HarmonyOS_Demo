@Component
export default struct FindComponent{
  @Consume userid:string;

  build(){
    Column(){
      Text("x..")
    }
  }

}