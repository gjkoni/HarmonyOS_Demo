import Logger from '../common/utils/Logger';
import { CourseModel, FreeProductItemModel, LessonDetailModel, SuggestProductItemModel } from '../model/CourseModel';
import List from '@ohos.util.List';
export class LastStudyViewModel{
  lesson_id:string
  lesson_title:string
  lesson_cover:string
  class_start:string
  class_end:string
  progress:number
}

export class ProductViewModel{
  product_id:string
  product_title:string
  product_cover:string
  product_teacher:string
  original_price:number
  price:number
  isfree:number
  ispublic:number
  product_period:number
  purchased:any
  class_id:number
}

function getLastStudy(): Promise<LastStudyViewModel>{
  return new Promise(async (resolve: Function, reject: Function) => {
    CourseModel.getLastStudy().then((data:LessonDetailModel)=>{
      Logger.info('viewmodel getLastStudy ok', JSON.stringify(data));
      let model = new LastStudyViewModel();
      model.lesson_id = data.lesson_id;
      model.lesson_title = data.lesson_title;
      model.lesson_cover = data.lesson_cover;
      model.class_start = data.class_start;
      model.class_end = data.class_end;
      model.progress = data.total_period;
      resolve(model)
    }).catch((err:string) => {
      Logger.error('viewmodel getLastStudy failed', err);
      reject(err)
    })
  });
}

function getFreeProduct(): Promise<ProductViewModel[]>{
  return new Promise(async (resolve: Function, reject: Function) => {
    CourseModel.getFreeProduct().then((data:FreeProductItemModel[])=>{
      Logger.info('viewmodel getFreeProduct ok', JSON.stringify(data));
      let list = []
      data.forEach(element => {
        let item = new ProductViewModel()
        Object.assign(item, element);
        list.push(item)
      });
      resolve(list)
    }).catch((err:string) => {
      Logger.error('viewmodel getFreeProduct failed', err);
      reject(err)
    })
  });
}

function getSuggestProduct(): Promise<ProductViewModel[]>{
  return new Promise(async (resolve: Function, reject: Function) => {
    CourseModel.getSuggestProduct().then((data:SuggestProductItemModel[])=>{
      Logger.info('viewmodel getSuggestProduct ok', JSON.stringify(data));
      let model = new Array<ProductViewModel>();
      data.forEach(element => {
        let item = new ProductViewModel()
        Object.assign(item, element);
        model.push(item)
      });
      resolve(model)
    }).catch((err:string) => {
      Logger.error('viewmodel getSuggestProduct failed', err);
      reject(err)
    })
  });
}

export {
  getLastStudy,
  getFreeProduct,
  getSuggestProduct
}