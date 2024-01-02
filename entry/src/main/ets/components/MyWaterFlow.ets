import display from '@ohos.display';
import Logger from '../common/utils/Logger';
@Component
export struct MyWaterFlow {
  @Link data: Array<any>
  private columns:number = 1;
  private columnGap:number = 0;
  private rowGap:number = 0;
  private paddingLR:boolean = false;
  private paddingTB:boolean = false;
  @BuilderParam itemBuilder: (item:any) => void;

  getColumnList(): Array<number>{
    let columns = []
    for (let index = 0; index < this.columns; index++) {
      columns.push(index)
    }
    return columns
  }

  getDataArrays():Array<Array<any>>{
    let result: any[][] = []
    if(this.data.length > 0){
      for (let index = 0; index < this.columns; index++) {
        result.push([])
      }
      for (let i = 0; i < this.data.length; i++) {
        Logger.debug(`余 ${i % this.columns}`)
        result[i % this.columns].push(this.data[i])
      }
    }
    let r = JSON.stringify(result)
    Logger.debug(`结果 ${r}`)
    return result
  }

  build() {
    Flex({ justifyContent:FlexAlign.SpaceBetween, alignItems: ItemAlign.Start }) {
      ForEach(this.getColumnList(), (column, index) =>{
          Column({space: this.rowGap}){
            ForEach(this.getDataArrays()[index], item => {
              this.itemBuilder(item)
            })
          }.width((display.getDefaultDisplaySync().width / display.getDefaultDisplaySync().densityPixels - (this.paddingLR ? this.columnGap * 2 : 0) - (this.columns - 1) * this.columnGap ) / this.columns)
      })
    }
    .width('100%').padding({
      left: this.paddingLR ? this.columnGap: 0,
      right: this.paddingLR ? this.columnGap: 0,
      top: this.paddingTB ? this.rowGap: 0,
      bottom: this.paddingTB ? this.rowGap: 0,
    })
  }
}
