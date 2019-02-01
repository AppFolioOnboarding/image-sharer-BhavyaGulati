import React, { Component } from 'react';
import { Button, FormRow, Alert } from 'react-gears';
import {observer, inject} from 'mobx-react'
import PropTypes from 'prop-types';
import PostFeedbackService from "../services/PostFeedbackService";

@inject('stores')
@observer
class FeedbackForm extends Component {

  constructor (props){
    super(props)

    this.handleNameChange = this.handleNameChange.bind(this);
    this.handleFeedbackChange = this.handleFeedbackChange.bind(this);
  }

  static propTypes = {
    stores: PropTypes.objectOf(PropTypes.shape({
      name: PropTypes.string.isRequired,
      feedback: PropTypes.string.isRequired,
    }))
  };

  handleNameChange(event) {
    this.props.stores.feedbackStore.setName(event.target.value);
  }

  handleFeedbackChange(event) {
    this.props.stores.feedbackStore.setFeedback(event.target.value);
  }

  handleSubmitClick = () => {
    new PostFeedbackService(this.props.stores.feedbackStore).postFeedback();
  };


  render() {
    return (
      <div className="formGroup">
        {this.props.stores.feedbackStore.AlertMessage? <Alert color="info" className="alert-message">{this.props.stores.feedbackStore.AlertMessage}</Alert> : null}
        <FormRow label="Your name" value={this.props.stores.feedbackStore.name} onChange={this.handleNameChange} labelSize="lg" width={{}} stacked/>
        <FormRow type="textarea" label="Comment" value={this.props.stores.feedbackStore.feedback} onChange={this.handleFeedbackChange} labelSize="lg" width={{}} stacked/>
        <Button color="primary" disabled={false} outline={false} onClick={this.handleSubmitClick} >
          Submit
        </Button>
      </div>
    )
  }
}

export default FeedbackForm;
