App = React.createClass
  getInitialState: ->
    data: []

  componentDidMount: ->
    $.get 'listings.json', ((data)->
      this.setState data: data
      # console.log data
      return
    ).bind this

  handleClick: (direction)->
    console.log direction

  render: ->
    <div className= 'app'>
      <h1>OneRent Listings</h1>
      <Listings data= {this.state.data} />
      <Arrows onClickEvent= {this.handleClick}/>
    </div>


Listings = React.createClass
  render: ->
    # headings = ['_id', 'body', 'type', 'replyUrl', 'url', 'title', 'price', 'region', 'location', 'hasPic', 'date', 'id']
    headings = ['_id', 'type', 'title', 'price', 'region', 'location', 'hasPic', 'date', 'id']
    
    for heading in headings
      $('#listings thead tr').append '<th>' + heading + '</th>'

    for listing in this.props.data
      $('#listings tbody').append '<tr></tr>'
      for heading in headings
        $('#listings tbody tr:last-child').append '<td>' + listing[heading] + '</td>'

    $("#listings").tablesorter(widgets: ['zebra'])


    <table id= 'listings' className= "tablesorter">
      <thead>
      <tr>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table>


Arrows = React.createClass
  handleClick: (e)->
    this.props.onClickEvent(e.target.value)
  render: ->
    <div className= 'buttons'>
      <input type= 'button' value= 'Left' onClick= {this.handleClick} />
      <input type= 'button' value= 'Right' onClick= {this.handleClick} />
    </div>


React.render(
  <App/>,
  document.getElementById('Container')
)
