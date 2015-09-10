App = React.createClass
  getInitialState: ->
    # headings: ['_id', 'body', 'type', 'replyUrl', 'url', 'title', 'price', 'region', 'location', 'hasPic', 'date', 'id']
    headings: ['_id', 'type', 'title', 'price', 'region', 'location', 'hasPic', 'date', 'id']
    listings: []
    page: 0

  getListings: (page) ->
    tableData =
      page: page
      pageSize: 15
    $.get 'listings.json', tableData, ((listings)->
      this.setState
        listings: listings
        page: page
      return
    ).bind this

  componentDidMount: ->
    this.getListings(this.state.page)

  handleClick: (direction)->
    if direction == 'Next'
      this.getListings(this.state.page + 1)
    else if direction == 'Previous' and this.state.page > 0
      this.getListings(this.state.page - 1)
    return

  render: ->
    <div className= 'app'>
      <h1>OneRent Listings</h1>
      <ListingsTable listings= {this.state.listings} headings= {this.state.headings} />
      <Arrows onClickEvent= {this.handleClick}  page= {this.state.page}/>
    </div>


ListingsTable = React.createClass
  render: ->
    tableHeadings = this.props.headings.map (heading) ->
      <ListingHeading>
        {heading}
      </ListingHeading>

    tableRows = this.props.listings.map ((listing) ->      
      <ListingRow headings= {this.props.headings}>
        {listing}
      </ListingRow>
    ).bind this

    <table id= 'listings' className= "tablesorter">
      <thead>
      <tr>
        {tableHeadings}
      </tr>
      </thead>
      <tbody>
        {tableRows}
      </tbody>
    </table>


ListingHeading = React.createClass
  render: ->
    <th>{this.props.children}</th>


ListingRow = React.createClass
  render: ->
    tableCells = this.props.headings.map ((heading) ->
      <ListingCell>
       {this.props.children[heading]}
      </ListingCell>
    ).bind this

    <tr>
     {tableCells}
    </tr>


ListingCell = React.createClass
  render: ->
    <td>{this.props.children}</td>


Arrows = React.createClass
  handleClick: (e)->
    this.props.onClickEvent(e.target.value)
  render: ->
    <div className= 'buttons'>
      <input type= 'button' value= 'Previous' onClick= {this.handleClick} />
      <input type= 'button' value= 'Next' onClick= {this.handleClick} />
      {this.props.page}
    </div>


React.render(
  <App/>,
  document.getElementById('Container')
)
