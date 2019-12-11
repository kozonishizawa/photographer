import React from 'react';
import Swiper from 'swiper';

export default class Slide extends React.Component {
  constructor(props) {

    super(props);

    this.state = {
      // dummy slides data
      slides: (function () {
        var slides = [];
        for (var i = 0; i < 600; i += 1) {
          slides.push('Slide ' + (i + 1));
        }
        return slides;
      }()),
      // virtual data
      virtualData: {
        slides: [],
      },
    }
  }
  componentDidMount() {
    const self = this;
    const swiper = new Swiper('.swiper-container', {
      // ...
      virtual: {
        slides: self.state.slides,
        renderExternal(data) {
          // assign virtual slides data
          self.setState({
            virtualData: data,
          });
        }
      },
    });
  }
  render() {

    <div className="swiper-container">
      <div className="swiper-wrapper">
        {/* It is important to set "left" style prop on every slide */}
        {this.state.virtualData.slides.map((slide, index) => (
          <div className="swiper-slide"
            key={index}
            style={{left: `${virtualData.offset}px`}}
          >{slide}</div>
        ))}
      </div>
    </div>

  }
}