import Logger from '../common/utils/Logger';
import { CourseModel, LessonDetailModel } from '../model/CourseModel';
export class LastStudyViewModel{
  lesson_title:string;
  lesson_cover:string;
  class_start:string;
  class_end:string;
  progress:number;
}

function getLastStudy(): Promise<LastStudyViewModel>{
  return new Promise(async (resolve: Function, reject: Function) => {
    CourseModel.getLastStudy().then((data:LessonDetailModel)=>{
      Logger.info('viewmodel getLastStudy ok', JSON.stringify(data));
      let model = new LastStudyViewModel();
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

export {
  getLastStudy
}