@Component
export default struct JobComponent{
  @Consume userid:string;

  build(){
    Column(){
      Text(this.userid)
      Text("JOB")
    }
  }

}