/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

export class ButtonInfoModel {
  index: number = 1;
  img: Resource = $r('app.media.course');
  selectImg: Resource = $r('app.media.course_active');
  title: Resource = $r('app.string.tab_course');
}

const buttonInfo: ButtonInfoModel[] = [
  {
    index: 0,
    img: $r('app.media.find'),
    selectImg: $r('app.media.find_active'),
    title: $r('app.string.tab_find')
  },
  {
    index: 1,
    img: $r('app.media.course'),
    selectImg: $r('app.media.course_active'),
    title: $r('app.string.tab_course')
  },
  {
    index: 2,
    img: $r('app.media.job'),
    selectImg: $r('app.media.job_active'),
    title: $r('app.string.tab_job')
  },
  {
    index: 3,
    img: $r('app.media.mine'),
    selectImg: $r('app.media.mine_active'),
    title: $r('app.string.tab_mine')
  }
]

export { buttonInfo }