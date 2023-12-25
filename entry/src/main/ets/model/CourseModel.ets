import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import { request } from '../common/utils/Request';
import Response from '../common/utils/Response';
export interface LessonDetailModel{
  product_id: string
  product_title: string
  product_description: string
  product_cover: string
  platform_id: string
  platform_days: any
  platform_title: string
  platform_description: string
  platform_website: string
  platform_redirect: string
  platform_status: any
  platform_logo: string
  original_price: any
  price: any
  isfree: any
  ispublic: any
  lesson_id: string
  org_id: number
  subclassify_id: any
  lesson_title: string
  lesson_cover: string
  wf: any
  class_id: string
  class_title: string
  class_start: string
  class_end: string
  class_cover: string
  class_description: string
  purchased: any
  changeSpeed: any
  canSeek: any
  assembled: any
  serverTime: string
  istest: any
  exam_start: string
  exam_end: string
  class_size: any
  class_status: any
  class_type: any
  fv: any
  tfv: any
  face: any
  face_time: any
  synopsis: any
  chapter_count: number
  section_count: number
  section_finished_count: number
  finished_time: string
  total_time: string
  finished_period: number
  total_period: number
  progress: any
  time_progress: any
  chapters: any
  pclist: any
  teachers: any
  askQuestions: any
  last_video_record: any
  teacher_names: any
}

export interface FreeProductItemModel{
  product_id:string
  product_title:string
  product_description:string
  product_cover:string
  original_price:number
  price:number
  isfree:number
  ispublic:number
  product_teacher:any
  product_period:number
  product_type:string
  time:string
  lesson_id:string
  lesson_title:string
  total_time:number
  total_period:number
  purchased:any
  wf:any
  class_id:number
  teacher_names:any
}

export interface SuggestProductItemModel {
  product_id: string
  store_product_id: any
  storeid: any
  product_title: string
  product_description: string
  product_cover: string
  medias: any
  original_price: number
  price: number
  isfree: number
  ispublic: number
  product_teacher: string
  product_period: number
  product_type: string
  product_category: number
  webpath_id: number
  product_status: number
  product_root: any
  class_id: number
  org_id: any
  time: string
  lessons: any
  shareVideos: any
  purchased: any
}


export class CourseModel{
  static getLastStudy(): Promise<LessonDetailModel>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let api = CommonConstants.apis.course.lastStudy;
      request(api.url, api.method).then((data: Response) => {
        resolve(data.data);
      }).catch((err: Error) => {
        Logger.error('lastStudy failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  static getFreeProduct(): Promise<FreeProductItemModel[]>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let api = CommonConstants.apis.course.freeLessonProductList;
      request(api.url, api.method, {top:10}).then((data: Response) => {
        resolve(data.data);
      }).catch((err: Error) => {
        Logger.error('getFreeProduct failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  static getSuggestProduct(): Promise<SuggestProductItemModel[]>{
    return new Promise(async (resolve: Function, reject: Function) => {
      let api = CommonConstants.apis.course.suggestLessonProductList;
      request(api.url, api.method, {top:10}).then((data: Response) => {
        resolve(data.data.list);
      }).catch((err: Error) => {
        Logger.error('getSuggestProduct failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}