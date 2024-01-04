/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export class CommonConstants {

  static readonly  RELEASE = false;

  static readonly ApiHost: string = "https://zptapi.smartmicky.com";
  static readonly ApiHost_DEV: string = "http://test.zpt.api.smartmicky.com";

  static readonly H5Host: string = "https://h5.smartmicky.com";
  static readonly H5Host_DEV: string = "http://h5test.smartmicky.com";

  static readonly apis:any = {
    user:{
      login: { url: '/api/smk/user/login', method: 'POST' },
      info: { url:'/api/smk/user/info', method: 'GET' }
    },
    course:{
      productTypes:{url:'/api/smk/product/product_type_list', method:'GET'},
      lastStudy:{url:'/api/smk/class/my_last_study_lesson', method:'GET'},
      freeLessonProductList :{url:'/api/smk/product/free_lesson_product_list', method:'GET'},
      suggestLessonProductList :{url:'/api/smk/product/suggest_lesson_product_list', method:'GET'}
    }
  };

  static readonly h5:any = {
    job:{
      index:  H5host() + `/studyindex.html`
    },
    find:{
      index:  H5host() + `/studyfind.html`
    }
  };

  static readonly pages:any = {
    main: { url: 'pages/Main' },
    login: {url:'pages/Login'},
    sms_login: {url:'pages/SmsLogin'}
  };

  static  readonly storageKeys:any = {
    userid:"userid",
  }

  static  readonly  SERVER_CODE_SUCCESS:number = 200;

  static readonly FIND_INDEX: number = 0;
  static readonly COURSE_INDEX: number = 1;
  static readonly JOB_INDEX: number = 2;
  static readonly MINE_INDEX: number = 3;

}

export enum Unit {
  Liter = 'L',
  Pcs = '个',
  Times = '次',
  Empty = ''
}

function H5host() {
  let server = CommonConstants.H5Host_DEV
  if(CommonConstants.RELEASE){
    server = CommonConstants.H5Host
  }
  return server
}
