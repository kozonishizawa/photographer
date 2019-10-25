import React from "react"
import PropTypes from "prop-types"
import Style from './HelloWorld.sass'
class HelloWorld extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div className={Style.hoge}>Greeting: {this.props.greeting}</div>
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};
export default HelloWorld
