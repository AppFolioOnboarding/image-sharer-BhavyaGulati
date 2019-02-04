import { action, observable, computed} from "mobx";

export default class FeedbackStore {
  @observable name = "";
  @observable feedback = "";
  @observable alertMessage = "";

  @action
  setName = (name) => {
    this.name = name;
  };

  @action setFeedback = (feedback) => {
    this.feedback = feedback;
  };

  @action setAlertMessage = (alertMessage) => {
    this.alertMessage = alertMessage;
  };

  @computed
  get AlertMessage () {
    return this.alertMessage;
  };
}

